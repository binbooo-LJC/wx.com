<?php
namespace app\common\model;

use think\Model;
use think\Db;
class User extends Model
{

    protected $insert   = ['create_time','username'];
    /**
     * 创建时间
     * @return bool|string
     */
    protected function setCreatetimeAttr()
    {
        return date('Y-m-d');
    }
    public function setUsernameAttr($value)
    {
        return strtolower($value);
    }

}