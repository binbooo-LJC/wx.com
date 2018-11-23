<?php
namespace app\admin\controller;


use app\common\model\Project as ProjectModel;
use app\common\controller\AdminBase;
use think\Db;

/**
 * 栏目管理
 * Class Category
 * @package app\admin\controller
 */
class Project extends AdminBase
{

    protected $Project_model;

    protected function _initialize()
    {
        parent::_initialize();
        $this->Project_model = new ProjectModel();
    }

    /**
     * 栏目管理
     * @return mixed
     */
    public function index()
    {

        $list=$this->Project_model->projectList();

        return $this->fetch('index',['list'=>$list]);
    }

    /**
     * 添加栏目
     * @param string $pid
     * @return mixed
     */
    public function add($pid = '')
    {
        return $this->fetch('add', ['pid' => $pid]);
    }

    /**
     * 保存栏目
     */
    public function save()
    {
        if ($this->request->isPost()) {
            $data            = $this->request->param();
//            $validate_result = $this->validate($data, 'Project');
            $validate=validate('Project');

            if (!$validate ->scene('save')->check($data)) {
                $this->error($validate->getError());
            } else {
                if ($this->Project_model->allowField(true)->save($data)) {
                    $this->success('保存成功',url('admin/project/index'));
                } else {
                    $this->error('保存失败');
                }
            }
        }
    }

    /**
     * 编辑栏目
     * @param $id
     * @return mixed
     */
    public function edit($id)
    {
        $project = $this->Project_model->getone($id);

        return $this->fetch('edit', ['project' => $project]);
    }

    /**
     * 更新栏目
     * @param $id
     */
    public function update($id)
    {
        if ($this->request->isPost()) {
            $data            = $this->request->param();
            $validate_result = $this->validate($data, 'Project');

            if ($validate_result !== true) {
                $this->error($validate_result);
            } else {

                    if ($this->Project_model->allowfield(true)->save($data, $id) !== false) {
                        $this->success('更新成功',url('admin/project/index'));
                    } else {
                        $this->error('更新失败');
                    }
                }
            }
        }


    /**
     * 删除栏目
     * @param $id
     */
    public function delete($id)
    {
      $count=DB::name('consume')->where('project',$id)->count();
      if($count>0){
          $this->error('该项目不能被删除，可选择弃用');
      }else{
          if($this->Project_model->destroy($id)){
              $this->success('删除成功');
          }else{
              $this->success('删除失败');
          }
      }

   }

    public function indexlist($keyword='',$page=1){
        $map=[];
        if($keyword){
            $map['b.name']=['like', "%{$keyword}%"];
        }
        $list=Db::name('consume')->alias('a')->join('think_project b','a.project=b.id')->where($map)->field('b.unit,b.name,sum(num) sum')->group('a.project')->paginate(30, false, ['page' => $page]);
        return $this->fetch('indexlist',['list'=>$list,'keyword'=>$keyword]);
    }
}