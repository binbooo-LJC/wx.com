-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2018-09-19 02:42:01
-- 服务器版本： 5.7.11
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wenxi_admin`
--

-- --------------------------------------------------------

--
-- 表的结构 `think_admin_user`
--

CREATE TABLE `think_admin_user` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `username` varchar(20) NOT NULL DEFAULT ''COMMENT
) ;

--
-- 转存表中的数据 `think_admin_user`
--

INSERT INTO `think_admin_user` (`id`, `username`, `password`, `status`, `create_time`, `last_login_time`, `last_login_ip`) VALUES
(1, 'admin', '67ad115fb2597e381fe3837a075ab3d7', 1, '2016-10-18 15:28:37', '2018-09-17 23:15:56', '127.0.0.1');

-- --------------------------------------------------------

--
-- 表的结构 `think_article`
--

CREATE TABLE `think_article` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '文章ID',
  `cid` smallint(5) UNSIGNED NOT NULL COMMENT '分类ID',
  `title` varchar(255) NOT NULL DEFAULT ''COMMENT
) ;

-- --------------------------------------------------------

--
-- 表的结构 `think_auth_group`
--

CREATE TABLE `think_auth_group` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(255) NOT NULL COMMENT '权限规则ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限组表';

--
-- 转存表中的数据 `think_auth_group`
--

INSERT INTO `think_auth_group` (`id`, `title`, `status`, `rules`) VALUES
(1, '超级管理组', 1, '1,2,3,73,74,5,6,7,8,9,10,11,12,39,40,41,42,43,14,13,20,21,22,23,24,15,25,26,27,28,29,30,16,17,44,45,46,47,48,18,49,50,51,52,53,19,31,32,33,34,35,36,37,54,55,58,59,60,61,62,56,63,64,65,66,67,57,68,69,70,71,72');

-- --------------------------------------------------------

--
-- 表的结构 `think_auth_group_access`
--

CREATE TABLE `think_auth_group_access` (
  `uid` mediumint(8) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限组规则表';

--
-- 转存表中的数据 `think_auth_group_access`
--

INSERT INTO `think_auth_group_access` (`uid`, `group_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `think_auth_rule`
--

CREATE TABLE `think_auth_rule` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL DEFAULT ''COMMENT
) ;

--
-- 转存表中的数据 `think_auth_rule`
--

INSERT INTO `think_auth_rule` (`id`, `name`, `title`, `type`, `status`, `pid`, `icon`, `sort`, `condition`) VALUES
(1, 'admin/System/default', '系统配置', 1, 1, 0, 'fa fa-gears', 0, ''),
(5, 'admin/Menu/default', '菜单管理', 1, 1, 0, 'fa fa-bars', 0, ''),
(6, 'admin/Menu/index', '后台菜单', 1, 1, 5, '', 0, ''),
(7, 'admin/Menu/add', '添加菜单', 1, 0, 6, '', 0, ''),
(8, 'admin/Menu/save', '保存菜单', 1, 0, 6, '', 0, ''),
(9, 'admin/Menu/edit', '编辑菜单', 1, 0, 6, '', 0, ''),
(10, 'admin/Menu/update', '更新菜单', 1, 0, 6, '', 0, ''),
(11, 'admin/Menu/delete', '删除菜单', 1, 0, 6, '', 0, ''),
(13, 'admin/project/index', '种类管理', 1, 1, 14, 'fa fa-sitemap', 0, ''),
(14, 'admin/Content/default', '种类管理', 1, 1, 0, 'fa fa-file-text', 56, ''),
(15, 'admin/consume/indexlist', '种类统计', 1, 1, 14, '', 0, ''),
(16, 'admin/User/default', '用户管理', 1, 1, 0, 'fa fa-users', 99, ''),
(17, 'admin/User/index', '会员vip', 1, 1, 16, '', 0, ''),
(18, 'admin/AdminUser/index', '管理员', 1, 0, 16, '', 0, ''),
(19, 'admin/AuthGroup/index', '权限组', 1, 0, 16, '', 0, ''),
(20, 'admin/Category/add', '添加栏目', 1, 0, 13, '', 0, ''),
(21, 'admin/Category/save', '保存栏目', 1, 0, 13, '', 0, ''),
(22, 'admin/Category/edit', '编辑栏目', 1, 0, 13, '', 0, ''),
(23, 'admin/Category/update', '更新栏目', 1, 0, 13, '', 0, ''),
(24, 'admin/Category/delete', '删除栏目', 1, 0, 13, '', 0, ''),
(25, 'admin/Article/add', '添加文章', 1, 0, 15, '', 0, ''),
(26, 'admin/Article/save', '保存文章', 1, 0, 15, '', 0, ''),
(27, 'admin/Article/edit', '编辑文章', 1, 0, 15, '', 0, ''),
(28, 'admin/Article/update', '更新文章', 1, 0, 15, '', 0, ''),
(29, 'admin/Article/delete', '删除文章', 1, 0, 15, '', 0, ''),
(30, 'admin/Article/toggle', '文章审核', 1, 0, 15, '', 0, ''),
(31, 'admin/AuthGroup/add', '添加权限组', 1, 0, 19, '', 0, ''),
(32, 'admin/AuthGroup/save', '保存权限组', 1, 0, 19, '', 0, ''),
(33, 'admin/AuthGroup/edit', '编辑权限组', 1, 0, 19, '', 0, ''),
(34, 'admin/AuthGroup/update', '更新权限组', 1, 0, 19, '', 0, ''),
(35, 'admin/AuthGroup/delete', '删除权限组', 1, 0, 19, '', 0, ''),
(36, 'admin/AuthGroup/auth', '授权', 1, 0, 19, '', 0, ''),
(37, 'admin/AuthGroup/updateAuthGroupRule', '更新权限组规则', 1, 0, 19, '', 0, ''),
(44, 'admin/User/add', '添加用户', 1, 0, 17, '', 0, ''),
(45, 'admin/User/save', '保存用户', 1, 0, 17, '', 0, ''),
(46, 'admin/User/edit', '编辑用户', 1, 0, 17, '', 0, ''),
(47, 'admin/User/update', '更新用户', 1, 0, 17, '', 0, ''),
(48, 'admin/User/delete', '删除用户', 1, 0, 17, '', 0, ''),
(49, 'admin/AdminUser/add', '添加管理员', 1, 0, 18, '', 0, ''),
(50, 'admin/AdminUser/save', '保存管理员', 1, 0, 18, '', 0, ''),
(51, 'admin/AdminUser/edit', '编辑管理员', 1, 0, 18, '', 0, ''),
(52, 'admin/AdminUser/update', '更新管理员', 1, 0, 18, '', 0, ''),
(53, 'admin/AdminUser/delete', '删除管理员', 1, 0, 18, '', 0, ''),
(54, 'admin/Slide/default', '做工统计', 1, 1, 0, 'fa fa-wrench', 55, ''),
(55, 'admin/consume/sms', '短信通知', 1, 0, 54, '', 0, ''),
(56, 'admin/recharge/index', '账单统计', 1, 1, 54, '', 0, ''),
(57, 'admin/Consume/index', '做工记录', 1, 1, 54, 'fa fa-link', 0, ''),
(58, 'admin/SlideCategory/add', '添加分类', 1, 0, 55, '', 0, ''),
(59, 'admin/SlideCategory/save', '保存分类', 1, 0, 55, '', 0, ''),
(60, 'admin/SlideCategory/edit', '编辑分类', 1, 0, 55, '', 0, ''),
(61, 'admin/SlideCategory/update', '更新分类', 1, 0, 55, '', 0, ''),
(62, 'admin/SlideCategory/delete', '删除分类', 1, 0, 55, '', 0, ''),
(63, 'admin/Slide/add', '添加轮播', 1, 0, 56, '', 0, ''),
(64, 'admin/Slide/save', '保存轮播', 1, 0, 56, '', 0, ''),
(65, 'admin/Slide/edit', '编辑轮播', 1, 0, 56, '', 0, ''),
(66, 'admin/Slide/update', '更新轮播', 1, 0, 56, '', 0, ''),
(67, 'admin/Slide/delete', '删除轮播', 1, 0, 56, '', 0, ''),
(68, 'admin/Link/add', '添加链接', 1, 0, 57, '', 0, ''),
(69, 'admin/Link/save', '保存链接', 1, 0, 57, '', 0, ''),
(70, 'admin/Link/edit', '编辑链接', 1, 0, 57, '', 0, ''),
(71, 'admin/Link/update', '更新链接', 1, 0, 57, '', 0, ''),
(72, 'admin/Link/delete', '删除链接', 1, 0, 57, '', 0, ''),
(73, 'admin/ChangePassword/index', '修改密码', 1, 1, 1, '', 0, '');

-- --------------------------------------------------------

--
-- 表的结构 `think_cash`
--

CREATE TABLE `think_cash` (
  `id` int(7) NOT NULL,
  `user_id` int(5) NOT NULL,
  `money` float NOT NULL,
  `creat_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `think_category`
--

CREATE TABLE `think_category` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `alias` varchar(50) DEFAULT ''COMMENT
) ;

--
-- 转存表中的数据 `think_category`
--

INSERT INTO `think_category` (`id`, `name`, `alias`, `content`, `thumb`, `icon`, `list_template`, `detail_template`, `type`, `sort`, `pid`, `path`, `create_time`) VALUES
(1, '分类一', '', '', '', '', '', '', 1, 0, 0, '0,', '2016-12-22 18:22:24');

-- --------------------------------------------------------

--
-- 表的结构 `think_consume`
--

CREATE TABLE `think_consume` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) NOT NULL COMMENT '外键 user表',
  `project` int(2) NOT NULL COMMENT '外键 project',
  `num` int(5) NOT NULL,
  `creat_time` date NOT NULL,
  `mark` char(50) DEFAULT NULL COMMENT AS `备注`,
  `statue` int(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `think_consume`
--

INSERT INTO `think_consume` (`id`, `user_id`, `project`, `num`, `creat_time`, `mark`, `statue`) VALUES
(110, 84, 1, 100, '2018-08-02', '', 1),
(111, 84, 2, 500, '2018-08-02', '', 1),
(113, 85, 1, 1500, '2018-08-02', '', 1),
(114, 85, 2, 2000, '2018-08-02', '', 0),
(116, 84, 1, 200, '2018-08-02', '', 0),
(117, 86, 1, 200, '2018-08-02', '', 0);

-- --------------------------------------------------------

--
-- 表的结构 `think_deposit_type`
--

CREATE TABLE `think_deposit_type` (
  `id` int(2) UNSIGNED NOT NULL,
  `name` char(20) NOT NULL,
  `premoney` int(5) NOT NULL COMMENT '原本金额',
  `money` int(6) NOT NULL,
  `statue` int(1) DEFAULT '1' COMMENT '1:启用 0 弃用'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `think_deposit_type`
--

INSERT INTO `think_deposit_type` (`id`, `name`, `premoney`, `money`, `statue`) VALUES
(1, '充值500送首次小奇泡免单', 500, 500, 0),
(2, '充值1000送200', 1000, 1200, 1);

-- --------------------------------------------------------

--
-- 表的结构 `think_link`
--

CREATE TABLE `think_link` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL DEFAULT ''COMMENT
) ;

-- --------------------------------------------------------

--
-- 表的结构 `think_nav`
--

CREATE TABLE `think_nav` (
  `id` int(10) UNSIGNED NOT NULL,
  `pid` int(10) UNSIGNED NOT NULL COMMENT '父ID',
  `name` varchar(20) NOT NULL COMMENT '导航名称',
  `alias` varchar(20) DEFAULT ''COMMENT
) ;

-- --------------------------------------------------------

--
-- 表的结构 `think_pay`
--

CREATE TABLE `think_pay` (
  `id` int(1) UNSIGNED NOT NULL,
  `name` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `think_pay`
--

INSERT INTO `think_pay` (`id`, `name`) VALUES
(1, '微信'),
(2, '支付宝'),
(3, '现金');

-- --------------------------------------------------------

--
-- 表的结构 `think_project`
--

CREATE TABLE `think_project` (
  `id` int(2) NOT NULL,
  `name` varchar(20) NOT NULL COMMENT '项目名称',
  `money` char(4) NOT NULL COMMENT '金额',
  `unit` char(10) NOT NULL COMMENT '单位',
  `statue` int(1) DEFAULT '1' COMMENT '1:启用 0 弃用'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `think_project`
--

INSERT INTO `think_project` (`id`, `name`, `money`, `unit`, `statue`) VALUES
(1, '长金鱼', '1.5', '件', 1),
(2, '帽子', '0.5', '个', 1);

-- --------------------------------------------------------

--
-- 表的结构 `think_recharge`
--

CREATE TABLE `think_recharge` (
  `id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `money` int(5) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mark` char(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `think_recharge`
--

INSERT INTO `think_recharge` (`id`, `user_id`, `money`, `time`, `mark`) VALUES
(2, 85, 2000, '2018-08-03 08:06:26', ''),
(3, 84, 400, '2018-08-03 09:06:30', ''),
(4, 85, 2000, '2018-09-17 15:19:23', '');

-- --------------------------------------------------------

--
-- 表的结构 `think_slide`
--

CREATE TABLE `think_slide` (
  `id` int(10) UNSIGNED NOT NULL,
  `cid` int(10) UNSIGNED NOT NULL COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '轮播图名称',
  `description` varchar(255) DEFAULT ''COMMENT
) ;

-- --------------------------------------------------------

--
-- 表的结构 `think_slide_category`
--

CREATE TABLE `think_slide_category` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '轮播图分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='轮播图分类表';

--
-- 转存表中的数据 `think_slide_category`
--

INSERT INTO `think_slide_category` (`id`, `name`) VALUES
(1, '首页轮播');

-- --------------------------------------------------------

--
-- 表的结构 `think_sms`
--

CREATE TABLE `think_sms` (
  `id` int(5) NOT NULL,
  `consumeId` int(5) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `statue` int(1) DEFAULT '1',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `think_system`
--

CREATE TABLE `think_system` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '配置项名称',
  `value` text NOT NULL COMMENT '配置项值'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统配置表';

--
-- 转存表中的数据 `think_system`
--

INSERT INTO `think_system` (`id`, `name`, `value`) VALUES
(1, 'site_config', 'a:7:{s:10:"site_title";s:30:"Think Admin 后台管理系统";s:9:"seo_title";s:0:"";s:11:"seo_keyword";s:0:"";s:15:"seo_description";s:0:"";s:14:"site_copyright";s:0:"";s:8:"site_icp";s:0:"";s:11:"site_tongji";s:0:"";}');

-- --------------------------------------------------------

--
-- 表的结构 `think_user`
--

CREATE TABLE `think_user` (
  `id` int(10) NOT NULL,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `mobile` varchar(12) DEFAULT ''COMMENT
) ;

--
-- 转存表中的数据 `think_user`
--

INSERT INTO `think_user` (`id`, `username`, `mobile`, `wx_code`, `balance`, `create_time`, `type`, `statue`) VALUES
(84, '李金城', '13366659939', '', 0, '2018-08-02', 1, 1),
(85, 'lijincheng', '13366659939', '', 500, '2018-08-02', 2, 1),
(86, '李', '18539981367', '', 0, '2018-08-02', 2, 1);

-- --------------------------------------------------------

--
-- 表的结构 `think_usertype`
--

CREATE TABLE `think_usertype` (
  `id` int(2) NOT NULL,
  `name` char(10) NOT NULL,
  `statue` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `think_usertype`
--

INSERT INTO `think_usertype` (`id`, `name`, `statue`) VALUES
(1, '车工', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `think_auth_group`
--
ALTER TABLE `think_auth_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_auth_group_access`
--
ALTER TABLE `think_auth_group_access`
  ADD UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `think_consume`
--
ALTER TABLE `think_consume`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `creat_time` (`creat_time`);

--
-- Indexes for table `think_deposit_type`
--
ALTER TABLE `think_deposit_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_pay`
--
ALTER TABLE `think_pay`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_project`
--
ALTER TABLE `think_project`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_recharge`
--
ALTER TABLE `think_recharge`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oder_time` (`time`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `think_slide_category`
--
ALTER TABLE `think_slide_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_sms`
--
ALTER TABLE `think_sms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_system`
--
ALTER TABLE `think_system`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_usertype`
--
ALTER TABLE `think_usertype`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `think_admin_user`
--
ALTER TABLE `think_admin_user`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `think_article`
--
ALTER TABLE `think_article`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章ID';
--
-- 使用表AUTO_INCREMENT `think_auth_group`
--
ALTER TABLE `think_auth_group`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `think_auth_rule`
--
ALTER TABLE `think_auth_rule`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `think_category`
--
ALTER TABLE `think_category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID';
--
-- 使用表AUTO_INCREMENT `think_consume`
--
ALTER TABLE `think_consume`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;
--
-- 使用表AUTO_INCREMENT `think_deposit_type`
--
ALTER TABLE `think_deposit_type`
  MODIFY `id` int(2) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `think_link`
--
ALTER TABLE `think_link`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `think_nav`
--
ALTER TABLE `think_nav`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `think_pay`
--
ALTER TABLE `think_pay`
  MODIFY `id` int(1) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `think_project`
--
ALTER TABLE `think_project`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `think_recharge`
--
ALTER TABLE `think_recharge`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- 使用表AUTO_INCREMENT `think_slide`
--
ALTER TABLE `think_slide`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `think_slide_category`
--
ALTER TABLE `think_slide_category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `think_sms`
--
ALTER TABLE `think_sms`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `think_system`
--
ALTER TABLE `think_system`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `think_user`
--
ALTER TABLE `think_user`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `think_usertype`
--
ALTER TABLE `think_usertype`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 限制导出的表
--

--
-- 限制表 `think_consume`
--
ALTER TABLE `think_consume`
  ADD CONSTRAINT `think_consume_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `think_user` (`id`);

--
-- 限制表 `think_recharge`
--
ALTER TABLE `think_recharge`
  ADD CONSTRAINT `think_recharge_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `think_user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
