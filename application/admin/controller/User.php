<?php
namespace app\admin\controller;

use app\common\model\User as UserModel;
use app\common\controller\AdminBase;
use think\Db;
use think\Session;

//use think\Session;
/**
 * 用户管理
 * Class AdminUser
 * @package app\admin\controller
 */
class User extends AdminBase
{
    protected $user_model;

    protected function _initialize()
    {
        parent::_initialize();
        $this->user_model = new UserModel();
    }

    /**
     * 用户管理
     * @param string $keyword
     * @param int    $page
     * @return mixed
     */
    public function index($keyword = '', $page = 1)
    {
        $map = [];
        if ($keyword) {
            $map['a.username|a.mobile'] = ['like', "%{$keyword}%"];
        }
        $user_list=DB::name('user')->alias('a')->join('think_usertype b','a.type=b.id','left')->where($map)->field('a.*,b.name typename')->order(['a.statue'=>'desc','a.id'])->paginate(10, false, ['page' => $page]);
//        $user_list = DB::name('user')->alias('a')->join('think_deposit_type b','a.type=b.id')->where($map)->field('a.id,a.username,a.mobile,a.balance,a.create_time,a.last_time,b.name,a.wx_code')->order('a.id DESC')->paginate(10, false, ['page' => $page]);

        return $this->fetch('index', ['user_list' => $user_list, 'keyword' => $keyword]);
    }

    /**
     * 添加用户
     * @return mixed
     */
    public function add()
    {
        $project=DB::name('project')->where('statue','1')->select();
        return $this->fetch('add',['project'=>$project]);
    }
    /**
     * 保存用户
     */
    public function save()
    {
        $user=new UserModel();
        if ($this->request->isPost()) {
            $data            = $this->request->post();
            $validate=validate('User');
            if(!$validate->scene('save')->check($data)){
               $this->error($validate->getError());
            }


            if(!$this->user_model->allowField(true)->save($data)){
                $this->error('添加失败');
            }
            $this->success('添加成功');

        }
    }

    /*
     * 查看用户消费记录
     *
     * */
        public function userbill($id,$page = 1,$date='',$keyword=''){
            $map['a.id']=$id;
            if ($keyword) {
                $map['c.name|a.mobile|a.username'] = ['like', "%{$keyword}%"];
            }
            if(!$date){
                $date=date('Y-m');
            }
            $map['date_format(b.creat_time ,"%Y-%m")']=$date;
            $list=DB::name('user')->alias('a')->join('think_consume b','b.user_id=a.id')->join('think_project c','c.id=b.project')->where($map)->field('a.username,a.mobile,b.creat_time,b.id billid,b.mark,b.num,c.name,c.money,c.unit,b.statue')->order(['b.creat_time'=>'desc','b.statue'=>'asc'])->paginate(10, false, ['page' => $page]);

            return $this->fetch('userbill', ['list' => $list,'keyword'=>$keyword,'id'=>$id,'date'=>$date]);
        }
    /*
     * 添加用户账单
     *
     *
     * */
    public function addbill($id){
        $project=DB::name('project')->where('statue','1')->select();
        $user=$this->user_model->find($id);
        return $this->fetch('addbill',['project'=>$project,'user'=>$user,'id'=>$id]);
    }
    /*
     * 保存账单
     *
     * */

    public function cheakcloth($data){
        $res['code']=0;
        foreach($data['consume'] as $k=>$v){
            foreach ($v as $ke=>$ve){
                if(array_key_exists("project",$v) && array_key_exists("num",$v)){
                    if($v['num']<=0){
                        $res['code']=1;
                        $res['message']='数量选择填写不正确';
                        return $res;
                    }
                }else{
                    $res['code']=1;
                    $res['message']='做工种类和数量不匹配';
                    return $res;
                }
            }
        }
        return $res;
    }
/*
 * 保存账单
 * */
    public function savebill($id){
        if($this->request->isPost()){
            $data=$this->request->post();
            if(!isset($data['consume'])){
                $this->error('未勾选做工种类');
            }
//            Session::set('date',$data['consume']);
//           判断勾选做工衣服种类是否合法
            $re=$this->cheakcloth($data);
            if($re['code']==1){
                $this->error($re['message']);
            }

            $list=$this->billData($id,$data['consume']);
            if(!DB::name('consume')->insertAll($list)){
                $this->error('系统繁忙');
            }
            $this->success('添加成功',url('admin/user/userbill',['id'=>$id]));
        }
    }
    /*
     * 处理账单数据
     * */
    public function billData($user_id,$data,$mark=''){
        $list=[];
        foreach ($data as $k=>$v){
            $list[$k]['project']=$v['project'];
            $list[$k]['num']=$v['num'];
            $list[$k]['user_id']=$user_id;
            $list[$k]['creat_time']=date('Y-m-d');
            $list[$k]['mark']=$mark;
        }
       return $list;
    }

    /*
     * 修改账单
     * */
    public function editbill($id){
        $re=DB::name('consume')->alias('a')->join('think_user b','a.user_id=b.id')->join('think_project c','a.project=c.id')->where('a.id',$id)->field('a.num,a.mark,a.project,b.username,b.id userid,a.statue,c.name,c.money')->find($id);
        $project=Db::name('project')->where('statue','1')->select();
//halt($re);
       return $this->fetch('editbill',['re'=>$re,'id'=>$id,'project'=>$project]);
    }
    /*
     * 更新账单
     * */
    public function updatebill($id,$user_id){
       if($this->request->isPost()){
           $data=$this->request->Post();
           $validate=validate('User');
          if(!$validate ->scene('updatebll')->check($data)) {
              $this->error($validate->getError());
          }else{

              if(!Db::name('consume')->where('id',$id)->update($data)){
                  $this->error('数据未变动');
              }
              $this->success('更新成功',url('admin/user/userbill',['id'=>$user_id]));

          }
       }
    }


    /**
     * 编辑用户
     * @param $id
     * @return mixed
     */
    public function edit($id)
    {
        $user = $user_list=DB::name('user')->alias('a')->join('think_usertype b','a.type=b.id','left')->where('a.id',$id)->field('a.*,b.name typename')->find();
        $usertype=DB::name('project')->where('statue','1')->select();

        return $this->fetch('edit', ['user' => $user,'usertype'=>$usertype]);
    }

    /**
     * 更新用户
     * @param $id
     */
    public function update($id)
    {
        if ($this->request->isPost()) {
            $data            = $this->request->post();
            $validate_result = $this->validate($data, 'User');
            if ($validate_result !== true) {
                $this->error($validate_result);
            } else {
                //            判断充值金额是否合法
                $user           = $this->user_model->find($id);
                $user->id       = $id;
                $user->username = $data['username'];
                $user->mobile   = $data['mobile'];
                $user->wx_code   = $data['wx_code'];
                $user->type   = $data['type'];
                $user->statue   = $data['statue'];
                $user->balance=$user['balance'];
                $user->save();
                if ($user->save() !== false) {
                    $this->success('更新成功');
                } else {
                    $this->error('更新失败');
                }

            }
        }
    }

    /**
     * 删除用户
     * @param $id
     */
    public function delete($id)
    {
        if ($this->user_model->destroy($id)) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

   /*
    * 效验勾选是否合法
    * */

/*
 *核查项目是否免单
 * $array 要判断的数据
 * str1 下标1 str2 下标表2
 * code=0 全部免单 code=1 部分免单 code=2 勾选的免单项目不在消费项目中
 * */
//    function cheakBill($array,$str1,$str2){
//        $res['code']=1; /*默认不全部面单*/
//        $cost='';
//        $price=[];
//        $project=DB::name('project')->select();
//        foreach ($project as $kk=>$vv){
//            $price[$vv['id']]=$vv['money'];
//        }
//       if(isset($array[$str2])){
//            if($array[$str1]==$array[$str2]){
//                $res['code']=0; /*全部免单*/
//                $res['cost']=0;
//                return $res;
//            }
//
//            $result=array_diff_assoc($array[$str2],$array[$str1]);
//            if(!empty($result)){
//                $res['code']=2;
//                return $res;
//            }
//            foreach ($result as $k=>$v){
//                $cost+=$price[$v];
//            }
//            $res['cost']=$cost;
//            return $res;
//        }else{
//            foreach ($array[$str1] as $key=>$vo){
//                $cost+=$price[$vo];
//            }
//           $res['cost']=$cost;
//           return $res;
//        }
//
//    }
/*
 * return 计算出充值首次消费的余额
 * */
//    public function cheakBalance($id='1', $cost=0){
//        $moeny=DB::name('deposit_type')->where('id',$id)->value('money');
//        $balance=$moeny-$cost;
//        return $balance;
//    }

/*
 * 整合插入到消费记录表中的数组
 *$id 用户id $arr1 消费项目，$arr2 免单项目
 * */
    public function consumeData($id,$data,$str1,$str2='')
    {
        $now=date('Y-m-d');
        $consume = $data[$str1];
        $list = [];
        $re=$this->getcyc();
        if (isset($data[$str2])) {
            $bill = $data[$str2];
            $result = array_diff_assoc($consume, $bill);
            foreach ($consume as $k => $v) {
                $arr['user_id'] = $id;
                $arr['project'] = $v;
                $arr['cyctime'] = date('Y-m-d',strtotime($re[$v] ."day"));
                if (array_key_exists($k, $result)) {
                    $arr['no_bill'] = 1;/*不免单*/

                } else {
                    $arr['no_bill'] = 0;/*免单*/
                }
                $list[] = $arr;
            }
        }else{
            foreach ($consume as $kk=>$vv){
                $arr['user_id'] = $id;
                $arr['project'] = $vv;
                $arr['no_bill'] = 1;
                $arr['cyctime'] = date('Y-m-d',strtotime($re[$vv] ."day"));
                $list[] = $arr;
            }
        }
        return $list;
    }

    /*
     * 获取项目id对应的周期
     * */
    public function getcyc(){

        $cyc=DB::name('project')->select();
        $re=[];
        foreach ($cyc as $k=>$v){
            $re[$v['id']]=$v['cyc'];
        }
        return $re;

    }

    /*
     *
     *
     * */



}