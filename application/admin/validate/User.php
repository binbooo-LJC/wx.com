<?php
namespace app\admin\validate;

use think\Validate;

class User extends Validate
{
    protected $rule = [
        'username'         => 'require',
        'mobile'           => 'number|length:11|require',
        'type'           => 'require|gt:0',
        'num'              =>'number|gt:0',
        'statue' =>'require',
        'project' =>'number|gt:0',
    ];
    protected $scene=[
        'save'=>['username','type','mobile'],
        'update'=>['name','money','cyc'],
        'updatebll'=>['num','project']
    ];
    protected $message = [
        'username.require'         => '请输入会员名',
        'type.require'         => '请选择员工类型',
        'type.gt'         => '职工种类数据非法',
        'mobile.number'            => '手机号格式错误',
        'mobile.length'            => '手机号长度错误',
        'num.number' =>'数量为数字',
        'project.number' =>'做工种类为数字',
        'num.gt' =>'数量为大于0的数字',
        'project.gt' =>'做工种类不合法',
    ];
}