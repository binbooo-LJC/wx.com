<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/7/12
 * Time: 17:39
 */

namespace app\common\model;
use think\Model;
use think\Db;
class Consume extends Model
{
    protected $tables='consume';
    protected $insert=['creat_time'];
    public function setCreat_timeAttr(){
        return date('Y-m-d');
    }

}