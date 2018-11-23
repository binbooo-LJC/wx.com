<?php
/**
 * Created by PhpStorm.
 * User: ljc
 * Date: 2018/11/23
 * Time: 10:40
 */

namespace app\admin\controller;
use app\admin\controller\Project as ProjectModel;
use app\common\controller\AdminBase;
use think\Db;

class projectlist extends AdminBase
{
    protected $Project_model;

    protected function _initialize()
    {
        parent::_initialize();
        $this->Project_model = new ProjectModel();
    }
    public function index($keyword='',$page=1){
        $map=[];
        if($keyword){
            $map['b.name']=['like', "%{$keyword}%"];
        }
        $list=Db::name('consume')->alias('a')->join('think_project b','a.project=b.id')->where($map)->field('b.unit,b.name,sum(num) sum')->group('a.project')->paginate(30, false, ['page' => $page]);
        return $this->fetch('index',['list'=>$list,'keyword'=>$keyword]);
    }
}