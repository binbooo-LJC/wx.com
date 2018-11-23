<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/7/12
 * Time: 17:17
 */
namespace app\admin\controller;
use app\common\model\Consume as ConsumeModel;
use app\common\controller\AdminBase;
use think\Db;
class Consume extends AdminBase{
    protected $consume_model;

    protected function _initialize()
    {
        parent::_initialize();
        $this->consume_model = new ConsumeModel();
    }

    public function index($keyword='',$statue='',$date='',$page=1){
        $map=[];
        if($keyword){
            $map['b.username|b.mobile|c.name']=['like', "%{$keyword}%"];
        }
        if(!$date){
            $date=date('Y-m');
        }
        if(!$statue){
            $map['a.statue']=0;
        }
        $map['date_format(a.creat_time ,"%Y-%m")']=$date;
        $list=Db('consume')->alias('a')->join('think_user b','a.user_id=b.id','left')->join('think_project c','a.project=c.id','left')->where($map)->field('a.id,b.username,a.creat_time,a.mark,a.num,a.statue,b.mobile,c.name project_name,c.money,c.unit')->order('a.creat_time desc,a.id')->paginate(30, false, ['page' => $page]);

        return $this->fetch('index',['list'=>$list,'keyword'=>$keyword,'date'=>$date,'statue'=>$statue]);
    }
    public function toggle($ids=[],$totle,$mark=''){
        if(empty($ids) ){
            $this->error('未勾选做工记录记录');
        }

        if(empty($totle) || !is_numeric($totle) || $totle<=0){
            $this->error('结算金额不合法');
        }

//        判断是否存在已结算记录
        $map['id']=['in',$ids];
        $map['statue']=1;
        $count=Db::name('consume')->where($map)->count();
        if($count){
            $this->error('所选包含已结算做工记录,请确认!');
        }
        $uids=Db::name('consume')->alias('a')->join('think_user b','b.id=a.user_id')->where('a.id','in',$ids)->field('b.id')->group('b.id')->select();
        if(count($uids)!=1){
            $this->error('勾选的做工记录为不同职工,请先进行筛选!');
        }
        $sum=Db::name('consume')->alias('a')->join('think_project b','a.project=b.id')->where('a.id','in',$ids)->field('b.money*a.num summoney')->sum('b.money*a.num');
        $balance=Db::name('user')->where('id',$uids[0]['id'])->value('balance');

        if($totle>$sum+$balance){
            $this->error('结算金额大于账单总额+往期结余，这么有钱！！！！');
        }
        $list['user_id']=$uids[0]['id'];
        $list['money']=$totle;
        $list['mark']=$mark;
        Db::startTrans();
        try{
            $this->consume_model->where('id','in',$ids)->update(['statue'=>1]);
            Db::name('user')->where('id',$uids[0]['id'])->update(['balance'=>$sum+$balance-$totle]);
            Db::name('recharge')->insert($list);
            // 提交事务
            Db::commit();
        } catch (\Exception $e) {
            // 回滚事务
            $this->error('保存失败');
            Db::rollback();
        }
        $this->success('保存成功');
    }

    /*
     * 计算总钱数
     * */
     public function sum(){
         if(!$this->request->ispost()){

             $this->error('请求不合法');

         }
         $id_data=$this->request->post();
         $ids=[];
         if($id_data){
             $ids=$id_data['data'];
         }
         if(!empty($ids)){
             $map['id']=['in',$ids];
             $map['statue']=1;
             $count=Db::name('consume')->where($map)->count();
             if($count){
//                 return 1;
                 $this->error('所选包含已结算做工记录,请确认!');
             }
             $uids=Db::name('consume')->alias('a')->join('think_user b','b.id=a.user_id')->where('a.id','in',$ids)->field('b.id')->group('b.id')->select();
             if(count($uids)!=1){
                 $this->error('勾选的做工记录为不同职工,请先进行筛选!');
             }
             $sum=Db::name('consume')->alias('a')->join('think_project b','a.project=b.id')->where('a.id','in',$ids)->field('b.money*a.num summoney')->sum('b.money*a.num');
             $balance=Db::name('user')->where('id',$uids[0]['id'])->value('balance');

            if($sum){
                $res['code']=1;
                $res['sum']=$sum;
                $res['balance']=$balance;
                return $res;
            }
         }
     }

}