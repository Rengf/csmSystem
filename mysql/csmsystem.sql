/*
Navicat MySQL Data Transfer

Source Server         : qwe
Source Server Version : 80013
Source Host           : localhost:3306
Source Database       : csmsystem

Target Server Type    : MYSQL
Target Server Version : 80013
File Encoding         : 65001

Date: 2019-07-22 10:02:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `address`
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `user_id` int(20) unsigned zerofill NOT NULL,
  `addressee` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel` char(11) COLLATE utf8_unicode_ci NOT NULL,
  `tel2` char(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `province` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `area` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `street` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip_code` char(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_default_address` char(2) COLLATE utf8_unicode_ci DEFAULT '0',
  `addressee_time` datetime DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  KEY `address_user_id` (`user_id`),
  CONSTRAINT `address_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('00000000000000000001', '00000000000000000001', '杜康酒', '13545896585', null, '中国', '湖北省', '武汉市', '洪山区', '民族大道182号中南民族大学南区', '430074', '0', '2019-03-20 23:50:52');
INSERT INTO `address` VALUES ('00000000000000000002', '00000000000000000009', '卡乐芙', '13545689564', '15895465689', '中国', '重庆', '重庆市', '渝中区', '解放碑邹容路125号27楼', '409000', '1', '2019-03-25 10:00:17');
INSERT INTO `address` VALUES ('00000000000000000003', '00000000000000000010', '金坷垃', '15645895689', '15489655689', '中国', '湖南省', '长沙市', '某个区', '某个街道某栋楼***号', '102315', '1', '2019-03-22 23:58:00');
INSERT INTO `address` VALUES ('00000000000000000009', '00000000000000000010', '杰克个', '15945641234', '15985465465', '中国', '黑龙江省', '大兴安岭地区', '漠河县', '发收款的积分好事', '465521', '0', '2019-05-03 23:16:30');

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `article_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `release_time` datetime DEFAULT NULL,
  `author` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(20) unsigned zerofill DEFAULT NULL,
  `status` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`article_id`),
  KEY `article_user_id` (`user_id`),
  CONSTRAINT `article_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('00000000000000000001', '通知', '<p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\">各单位：</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\">根据上级通知精神，结合学校实际，经学校研究，现将我校2019年清明节放假安排通知如下：</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\">一、放假时间安排</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\">4月5日清明节（星期五）放假，与周末连休。</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\">二、教学活动安排</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\">4月5日清明节（星期五）为法定节假日，不安排教学活动。4月6日（星期六）、4月7日（星期日）已安排的教学活动照常进行。</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\">三、注意事项</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\">清明节放假期间，各单位要妥善安排好假期值班和安全保卫工作：严格教职工考勤制度，按照学校规定履行请销假和报告报备手续；加强学生安全教育和管理工作，强化学生防盗防骗和遵纪守法意识，严格履行请销假审批备案等日常管理制度，做好家校联系工作，确保学生平安度假；高度重视稳定工作，加强值守应急，确保信息畅通；强化安全意识，注意出行安全，切实做好防火、防盗工作，消除各种安全隐患；严格落实各项防控措施，遇有重大突发事件，要按规定及时报告并妥善处置，确保师生员工平安度过节假日。</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\">请各单位将值班人员安排表电子版（包括带班领导、值班人员姓名、电话）于4月1日前通过以下邮箱分别报送学校办公室和保卫处（不交纸质版）。</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\">学校办公室：xiaoban@mail.scuec.edu.cn</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\">保卫处：mdbwc@mail.scuec.edu.cn</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\"><br style=\"padding: 0px; margin: 0px; border: 0px;\"/></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: justify;\">特此通知</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: right;\"><br style=\"padding: 0px; margin: 0px; border: 0px;\"/></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: right;\">中南民族大学办公室</p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: right;\">2019年3月20日</p><p><br/></p>', '2019-04-07 15:47:15', '郭海军', '00000000000000000010', '1');
INSERT INTO `article` VALUES ('00000000000000000003', '阿发吉林省的叫法是打开', '<p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\">为进一步拓宽高校毕业生就业渠道，促进学校毕业生充分就业、高质量就业</span></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\">一、活动名称</span></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\">中南民族大学2019届毕业生春季供需见面会</span></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\">二、活动时间、地点</span></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\">时间：2019年3月16日(周六) 上午8:30—12:00</span></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\">地点：中南民族大学体育馆</span></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\">三、参会对象</span></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\">应往届毕业生</span></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\">活动详情请见：</span><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\">http://job.scuec.edu.cn/eweb/jygl/zpfw.so?modcode=jygl_scfwzpxx&amp;subsyscode=zpfw&amp;type=viewZpxx&amp;id=8XTh3UPAf9TnP31qa1pKtd&amp;tdsourcetag=s_pctim_aiomsg</span></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal;\"><br style=\"padding: 0px; margin: 0px; border: 0px;\"/><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\"></span></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: right;\"><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\">中南民族大学招生就业工作处</span></p><p class=\"p_text_indent_2\" style=\"padding: 0px; margin-top: 20px; margin-bottom: 0px; border: 0px; text-indent: 2em; font-size: 15px; line-height: 22px; font-family: &quot;Microsoft YaHei&quot;; white-space: normal; text-align: right;\"><span style=\"padding: 0px; margin: 0px; border: 0px; font-size: 14px;\">2019<span style=\"padding: 0px; margin: 0px; border: 0px; font-family: 宋体;\">年</span><span style=\"padding: 0px; margin: 0px; border: 0px; font-family: calibri;\">3</span><span style=\"padding: 0px; margin: 0px; border: 0px; font-family: 宋体;\">月</span><span style=\"padding: 0px; margin: 0px; border: 0px; font-family: calibri;\">12</span><span style=\"padding: 0px; margin: 0px; border: 0px; font-family: 宋体;\">日</span></span></p><p><br/></p>', '2019-04-08 13:28:40', '黑寡妇', '00000000000000000010', '1');

-- ----------------------------
-- Table structure for `cart`
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `cart_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `user_id` int(20) unsigned zerofill DEFAULT NULL,
  `goods_id` int(20) unsigned zerofill DEFAULT NULL,
  `goods_count` int(5) DEFAULT NULL,
  `addcart_time` datetime DEFAULT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `cart_user_id` (`user_id`),
  KEY `cart_goods_id` (`goods_id`),
  CONSTRAINT `cart_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES ('00000000000000000067', '00000000000000000010', '00000000000000000013', '4', '2019-04-30 18:52:37');
INSERT INTO `cart` VALUES ('00000000000000000069', '00000000000000000010', '00000000000000000011', '3', '2019-05-07 19:16:05');

-- ----------------------------
-- Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `user_id` int(20) unsigned zerofill DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `goods_id` int(20) unsigned zerofill DEFAULT NULL,
  `comment_time` datetime DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `comment_user_id` (`user_id`),
  KEY `comment_goods_id` (`goods_id`),
  CONSTRAINT `comment_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `comment_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('00000000000000000001', '00000000000000000010', 'φ速度覅收货', '00000000000000000011', '2019-05-01 20:05:08');
INSERT INTO `comment` VALUES ('00000000000000000002', '00000000000000000010', '戊二醛双方各得分公司答复', '00000000000000000011', '2019-05-01 20:22:59');
INSERT INTO `comment` VALUES ('00000000000000000003', '00000000000000000010', '很好喝！', '00000000000000000013', '2019-05-08 11:13:28');

-- ----------------------------
-- Table structure for `goods`
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goods_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `goods_picture` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `goods_price` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `goods_type_id` int(20) unsigned zerofill NOT NULL,
  `goods_description` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `addgoods_time` datetime NOT NULL,
  `stock` int(10) DEFAULT '0',
  `sales` int(10) DEFAULT '0',
  PRIMARY KEY (`goods_id`),
  KEY `goods_goods_type_id` (`goods_type_id`),
  CONSTRAINT `goods_goods_type_id` FOREIGN KEY (`goods_type_id`) REFERENCES `goods_type` (`goods_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('00000000000000000008', '小米note 3', '../../static/image/xiaomi_note3.jpg', '1999', '00000000000000000012', '1600 万自拍相机\n2μm 合成大像素，出色暗光表现\n细节丰富的好照片，一定对画面亮部、暗部有更好的表达。小米Note 3 前置 1600 万像素感光元件，光线充足时，超高像素带来更好的解析力。暗光拍照时，智能将 4 个像素合成为一个 2μm 的大像素，提升暗部解析力，让照片更通透。', '2019-03-28 12:37:12', '-6', '6');
INSERT INTO `goods` VALUES ('00000000000000000009', '华为p30     ', '../../static/image/huawei_p20.jpg', '1999', '00000000000000000012', '标配6G+64G存储组合，运行安卓8.1的系统，用户体验也是十分流畅，后置2000万+1200万徕卡双摄', '2019-03-28 12:40:53', '-5', '5');
INSERT INTO `goods` VALUES ('00000000000000000010', '荣耀magic', '../../static/image/rongyao_magic.png', '3799', '00000000000000000012', '1600万像素（彩色，f/1.8光圈）+2400万像素（黑白，f/1.8光圈）+1600万像素（超广角，f/2.2光圈，支持固定焦距），支持AIS防抖。备注：不同拍照模式的照片像素可能有差异，请以实际为准。', '2019-03-28 12:44:33', '-11', '11');
INSERT INTO `goods` VALUES ('00000000000000000011', 'Alienware 17', '../../static/image/Alienware_17.jpg', '20000', '00000000000000000013', '内存容量	16GB（8GB×2）\n内存类型	DDR4 2667MHz\n插槽数量	2xSO-DIMM\n硬盘容量	512GB+1TB\n硬盘描述	混合硬盘（PCIe SSD+7200转HDD）\n光驱类型	无内置光驱\n显示屏\n触控屏	不支持触控\n屏幕尺寸	17.3英寸\n显示比例	16:9\n屏幕分辨率	1920x1080\n屏幕技术	FHD，LED背光，IPS防眩光屏，300-nits，Tobii IR视觉跟踪\n显卡\n显卡类型	发烧级独立显卡\n显卡芯片	NVIDIA GeForce GTX 1070\n显存容量	8GB\n显存类型	GDDR5纠错\n显存位宽	256bit', '2019-03-28 13:02:04', '76', '24');
INSERT INTO `goods` VALUES ('00000000000000000012', '联想拯救者 Y7000', '../../static/image/lianxiang_y7000.jpg', '6699', '00000000000000000013', '屏幕：15.6英寸\n\n分辨率：1920x1080\n\nCPU主频：2.3GHz\n\n核心数：四核心/八线程\n\n显卡类型：性能级独立显卡\n\n显存容量：4GB\n\n电池类型：3芯锂电池，52.5瓦时\n\n续航时间：视具体使用环境而定', '2019-03-28 13:09:11', '-8', '8');
INSERT INTO `goods` VALUES ('00000000000000000013', '脉动', '../../static/image/maidong.jpg', '4', '00000000000000000015', '脉动是一款运动维生素饮料，于2003年上市。以居住在城市的年轻人，年龄约18-35之间，由于工作需求，经常在户外活动的人群为消费主体。\n脉动由其广告：“回复状态 随时脉动向前” 可见，其目标市场定位在18-35岁左右的学生、年轻人、时尚运动爱好者、白领', '2019-03-28 21:50:52', '964', '42');
INSERT INTO `goods` VALUES ('00000000000000000014', '红富士苹果', '../../static/image/hongfushi.jpg', '79.8', '00000000000000000018', '红富士苹果带箱10斤新鲜当季水果小嘎啦批发包邮', '2019-04-02 16:48:46', '-9', '9');
INSERT INTO `goods` VALUES ('00000000000000000015', 'Vue2实践揭秘', '../../static/image/vue2.jpg', '55.3', '00000000000000000007', 'ISBN编号: 9787121310683', '2019-04-02 16:53:05', '-9', '9');
INSERT INTO `goods` VALUES ('00000000000000000016', '美的（Midea） 冰箱 ', '../../static/image/bingxiang.jpg', '3799', '00000000000000000021', '468升无霜十字对开门 多门变频冰箱', '2019-04-02 20:00:38', '-9', '9');
INSERT INTO `goods` VALUES ('00000000000000000020', 'vivo ', '../../static/image/rongyao_magic.png', '1565', '00000000000000000012', '发开始交电话费卡死的话费卡死的话费卡士大夫卡机是的副科级', '2019-05-03 22:23:18', '-2', '2');

-- ----------------------------
-- Table structure for `goods_type`
-- ----------------------------
DROP TABLE IF EXISTS `goods_type`;
CREATE TABLE `goods_type` (
  `goods_type_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `goods_type_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `addgoodstype_time` datetime DEFAULT NULL,
  `goods_type_count` int(3) DEFAULT '0',
  PRIMARY KEY (`goods_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of goods_type
-- ----------------------------
INSERT INTO `goods_type` VALUES ('00000000000000000007', '书籍', '2019-03-28 12:27:31', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000008', '音像', '2019-03-28 12:27:56', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000009', '服饰', '2019-03-28 12:28:13', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000010', '食品', '2019-03-28 12:28:32', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000011', '电子', '2019-03-28 12:28:47', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000012', '手机', '2019-03-28 12:29:25', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000013', '电脑', '2019-03-28 12:29:30', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000014', '数码', '2019-03-28 12:29:35', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000015', '饮料', '2019-03-28 12:30:05', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000017', '文具', '2019-03-28 12:31:19', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000018', '水果', '2019-03-28 12:31:32', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000019', '酒类', '2019-04-02 15:23:01', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000020', '空调', '2019-04-02 15:24:29', '0');
INSERT INTO `goods_type` VALUES ('00000000000000000021', '冰箱', '2019-04-02 15:24:41', '0');

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `order_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `order_no` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `order_status` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '0',
  `goods_id` int(20) unsigned zerofill DEFAULT NULL,
  `product_count` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `product_amount_total` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_amount_total` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logistics` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logistics_fee` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `invoice` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `invoice_id` int(20) unsigned zerofill DEFAULT NULL,
  `address_id` int(20) unsigned zerofill DEFAULT NULL,
  `order_logistics_id` int(20) unsigned zerofill DEFAULT NULL,
  `pay_channel` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `out_trade_no` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `addorder_time` datetime DEFAULT NULL,
  `payed_time` datetime DEFAULT NULL,
  `delivery_time` datetime DEFAULT NULL,
  `user_id` int(20) unsigned zerofill DEFAULT NULL,
  `user_remarks` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_settlement_status` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_settlement_time` datetime DEFAULT NULL,
  `sales_way` char(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '0',
  PRIMARY KEY (`order_id`),
  KEY `order_invoice_id` (`invoice_id`),
  KEY `order_order_logistic_id` (`order_logistics_id`),
  KEY `order_goods_id` (`goods_id`),
  KEY `order_user_id` (`user_id`),
  KEY `order_address_id` (`address_id`),
  CONSTRAINT `order_address_id` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `order_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `order_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('00000000000000000049', '62058221322350', '4', '00000000000000000013', '2', '8', '24', '中通', '16', '是', '00000000000000000036', '00000000000000000003', '00000000000000000024', '信用卡', '48859901149740', '2019-05-23 14:17:53', '2019-03-31 14:17:56', '2019-04-01 23:12:49', '00000000000000000010', '问题', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000050', '77293956868135', '2', '00000000000000000011', '2', '40000', '40020', '顺丰', '20', '是', '00000000000000000037', '00000000000000000003', '00000000000000000026', '支付宝', '42962935184516', '2019-05-23 22:30:09', '2019-04-01 22:30:12', '2019-04-03 13:03:20', '00000000000000000010', '发酵的合法', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000051', '91491429338878', '2', '00000000000000000011', '1', '20000', '20016', '中通', '16', '否', null, '00000000000000000003', '00000000000000000025', '微信', '75038561575233', '2019-05-19 22:37:05', '2019-04-01 22:37:07', '2019-04-03 13:02:00', '00000000000000000010', '权威人穷', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000052', '43441837569127', '0', '00000000000000000011', '2', '40000', '40020', '顺丰', '20', '是', '00000000000000000038', '00000000000000000003', null, '货到付款', null, '2019-05-22 13:10:36', null, null, '00000000000000000010', '广发发呆放好久', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000053', '72352147679386', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, '00000000000000000027', '线下支付', null, '2019-05-21 23:17:53', null, '2019-04-04 16:26:57', null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000054', '11501754840130', '2', '00000000000000000011', '1', '20000', '20015', '圆通', '15', '是', '00000000000000000039', '00000000000000000003', '00000000000000000028', '支付宝', '95946162818910', '2019-05-18 23:27:50', '2019-04-03 23:27:53', '2019-04-04 16:27:04', '00000000000000000010', '阿斯蒂芬卡时间段里疯狂', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000055', '30778175068629', '2', '00000000000000000011', '1', '20000', '20000', null, null, null, null, null, null, '线下支付', null, '2019-05-20 16:27:34', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000056', '512836566174', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-05-21 16:29:48', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000057', '5298583080011', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-05-18 16:34:42', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000058', '99321861545968', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-05-17 16:48:23', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000059', '76372842096443', '1', '00000000000000000011', '2', '40000', '40012', '韵达', '12', '是', '00000000000000000040', '00000000000000000003', null, '信用卡', '98842254636867', '2019-05-20 16:49:29', '2019-04-04 16:49:33', null, '00000000000000000010', '尽快发货', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000060', '77778621399616', '1', '00000000000000000013', '2', '8', '28', '顺丰', '20', '是', '00000000000000000041', '00000000000000000003', null, '支付宝', '58885013154170', '2019-05-18 16:56:23', '2019-04-04 16:56:26', null, '00000000000000000010', '发卡时间段里发酵', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000061', '78209524589013', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-04-22 16:58:26', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000062', '97831511167620', '1', '00000000000000000011', '1', '20000', '20000', '', '0', '否', null, '00000000000000000003', null, '信用卡', '19446834981983', '2019-04-17 15:31:33', '2019-04-08 15:31:34', null, '00000000000000000010', '按时发达', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000063', '37994242556840', '2', '00000000000000000010', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-04-16 16:34:37', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000064', '37757957535493', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-04-19 16:47:20', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000065', '90144370298758', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-04-18 16:47:21', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000066', '44258605139286', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-04-20 16:47:21', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000067', '73298444258740', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-04-22 16:47:21', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000068', '30743124978894', '2', '00000000000000000015', '1', '55.3', '67.3', '韵达', '12', null, null, '00000000000000000003', null, '货到付款', null, '2019-04-21 23:03:41', null, null, '00000000000000000010', '扁桃仁', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000069', '60953386813480', '2', '00000000000000000015', '1', '55.3', '67.3', '韵达', '12', '是', '00000000000000000043', '00000000000000000003', '00000000000000000034', '货到付款', null, '2019-04-17 23:03:40', null, '2019-05-24 23:09:38', '00000000000000000010', '扁桃仁', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000070', '56302118332631', '2', '00000000000000000012', '1', '6699', '6699', null, null, null, null, null, null, '线下支付', null, '2019-04-18 23:04:16', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000071', '36591078495685', '2', '00000000000000000012', '1', '6699', '6699', null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:16', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000072', '95433952408943', '2', '00000000000000000009', '1', '1999', '1999', null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:18', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000073', '28617873313707', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:19', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000074', '21053712301357', '2', '00000000000000000014', '1', '79.8', '79.8', null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:20', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000075', '12765065728850', '2', '00000000000000000014', '1', '79.8', '79.8', null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:20', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000076', '4654653440775', '2', '00000000000000000015', '1', '55.3', '55.3', null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:21', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000077', '55962542011561', '2', '00000000000000000015', '1', '55.3', '55.3', null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:21', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000078', '37587893521408', '2', '00000000000000000016', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:22', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000079', '407553546952', '2', '00000000000000000011', '1', '20000', '20000', null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:23', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000080', '12574821756547', '2', '00000000000000000011', '1', '20000', '20000', null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:23', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000081', '78301496596373', '2', '00000000000000000010', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:24', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000082', '62488245561407', '2', '00000000000000000010', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:24', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000083', '82325947710795', '2', '00000000000000000008', '1', null, null, null, null, null, null, null, null, '线下支付', null, '2019-04-15 23:04:27', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000084', '80801671978362', '1', '00000000000000000014', '1', '55.3', '70.3', '圆通', '15', '否', null, '00000000000000000003', null, '信用卡', '75627003010835', '2019-04-19 22:44:25', '2019-04-16 22:44:27', null, '00000000000000000010', '欠人情', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000085', '39668752061863', '2', '00000000000000000014', '1', '55.3', '70.3', '圆通', '15', null, null, '00000000000000000003', null, '信用卡', null, '2019-04-21 22:44:25', null, null, '00000000000000000010', '欠人情', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000086', '62853008458151', '1', '00000000000000000016', '1', '79.8', '91.8', '韵达', '12', '是', '00000000000000000044', '00000000000000000003', null, '微信', '2247050012565', '2019-04-23 22:44:59', '2019-04-16 22:45:02', null, '00000000000000000010', '去玩儿群翁', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000087', '84297940769188', '2', '00000000000000000015', '1', '79.8', '95.8', '中通', '16', '是', '00000000000000000045', '00000000000000000003', '00000000000000000031', '信用卡', '84893703932929', '2019-04-15 22:45:44', '2019-04-16 22:45:47', '2019-04-16 23:03:34', '00000000000000000010', '阿斯蒂芬', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000088', '26767413195192', '2', '00000000000000000016', '1', '3799', '3819', '顺丰', '20', '是', '00000000000000000046', '00000000000000000003', '00000000000000000030', '微信', '85648039813060', '2019-04-16 22:47:12', '2019-04-16 22:47:15', '2019-04-16 23:02:34', '00000000000000000010', '二条问题', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000089', '34195351842852', '2', '00000000000000000009', '1', '1999', '1999', null, null, null, null, null, null, '线下支付', null, '2019-05-17 22:47:32', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000090', '89560132229515', '2', '00000000000000000009', '1', '1999', '1999', null, null, null, null, null, null, '线下支付', null, '2019-05-20 22:47:32', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000091', '77515462663821', '2', '00000000000000000010', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-05-19 22:47:33', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000092', '81851817074765', '2', '00000000000000000014', '1', '79.8', '79.8', null, null, null, null, null, null, '线下支付', null, '2019-05-18 22:47:36', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000093', '33109579687656', '2', '00000000000000000014', '1', '79.8', '79.8', null, null, null, null, null, null, '线下支付', null, '2019-05-21 22:47:36', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000094', '94855861917538', '2', '00000000000000000015', '1', '55.3', '55.3', null, null, null, null, null, null, '线下支付', null, '2019-04-22 22:47:37', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000095', '54587613751375', '2', '00000000000000000015', '1', '55.3', '55.3', null, null, null, null, null, null, '线下支付', null, '2019-04-16 22:47:37', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000096', '11237578102887', '2', '00000000000000000012', '1', '6699', '6699', null, null, null, null, null, null, '线下支付', null, '2019-04-16 22:47:38', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000097', '47612259562680', '2', '00000000000000000012', '1', '6699', '6699', null, null, null, null, null, null, '线下支付', null, '2019-05-08 22:47:38', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000098', '82446759996516', '2', '00000000000000000008', '1', null, null, null, null, null, null, null, null, '线下支付', null, '2019-04-16 22:47:41', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000099', '88744134457872', '2', '00000000000000000008', '1', null, null, null, null, null, null, null, null, '线下支付', null, '2019-04-16 22:47:42', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000100', '10993954119986', '2', '00000000000000000011', '1', '20000', '20000', null, null, null, null, null, null, '线下支付', null, '2019-05-08 22:47:43', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000101', '59503333409930', '2', '00000000000000000011', '1', '20000', '20000', null, null, null, null, null, null, '线下支付', null, '2019-04-16 22:47:43', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000102', '15759975614254', '2', '00000000000000000010', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-04-16 22:47:44', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000103', '27916964701479', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-04-16 22:47:46', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000104', '31234078213367', '1', '00000000000000000016', '1', '3799', '3815', '中通', '16', '是', '00000000000000000047', '00000000000000000003', null, '微信', '91927161242938', '2019-04-17 13:05:27', '2019-04-17 13:05:29', null, '00000000000000000010', '确认hi王企鹅吼', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000105', '29293514243556', '2', '00000000000000000016', '1', '3799', '3815', '中通', '16', null, null, '00000000000000000003', null, '微信', null, '2019-04-17 13:05:27', null, null, '00000000000000000010', '确认hi王企鹅吼', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000106', '98034161339902', '1', '00000000000000000012', '1', '6699', '6714', '圆通', '15', '是', '00000000000000000049', '00000000000000000003', null, '信用卡', '96984638786493', '2019-04-17 13:06:59', '2019-04-17 13:07:02', null, '00000000000000000010', '话说客户', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000107', '58699673498302', '2', '00000000000000000012', '1', '6699', '6714', '圆通', '15', null, null, '00000000000000000003', null, '信用卡', null, '2019-04-17 13:06:59', null, null, '00000000000000000010', '话说客户', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000108', '12309529973117', '2', '00000000000000000015', '1', '55.3', '55.3', null, null, null, null, null, null, '线下支付', null, '2019-04-17 13:07:44', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000109', '65280550881341', '2', '00000000000000000015', '1', '55.3', '55.3', null, null, null, null, null, null, '线下支付', null, '2019-04-17 13:07:44', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000110', '3230983104947', '2', '00000000000000000010', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-04-17 13:07:46', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000111', '30155790635046', '2', '00000000000000000010', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-04-17 13:07:46', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000112', '25616942810872', '2', '00000000000000000011', '1', '20000', '20000', null, null, null, null, null, null, '线下支付', null, '2019-04-17 13:07:47', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000113', '34146345999084', '2', '00000000000000000011', '1', '20000', '20000', null, null, null, null, null, null, '线下支付', null, '2019-04-17 13:07:47', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000114', '37542641524739', '2', '00000000000000000016', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-04-17 13:07:49', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000115', '30565693928596', '2', '00000000000000000016', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-04-17 13:07:49', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000116', '51056044574100', '2', '00000000000000000015', '1', '55.3', '71.3', '中通', '16', '是', '00000000000000000050', '00000000000000000003', '00000000000000000032', '微信', '95068171118058', '2019-04-28 17:43:16', '2019-04-28 17:43:22', '2019-04-28 17:45:02', '00000000000000000010', '艾弗森典范', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000117', '57619789973022', '2', '00000000000000000011', '3', '60000', '60016', '中通', '16', null, null, '00000000000000000003', null, '信用卡', null, '2019-05-04 21:37:30', null, null, '00000000000000000010', '去玩儿群翁', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000118', '93233215538299', '2', '00000000000000000011', '3', '60000', '60015', '圆通', '15', '是', '00000000000000000052', '00000000000000000003', null, '支付宝', null, '2019-05-04 22:38:44', null, null, '00000000000000000010', '发撒的发生的发生', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000119', '29688702385148', '0', '00000000000000000011', '4', '80000', '80000', '其他', '0', '否', null, '00000000000000000003', null, '货到付款', null, '2019-05-04 22:45:19', null, null, '00000000000000000010', '阿斯顿发送到发送到', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000120', '78192500496580', '0', '00000000000000000014', '1', '79.8', '94.8', '圆通', '15', '否', null, '00000000000000000003', null, '微信', null, '2019-05-04 22:50:27', null, null, '00000000000000000010', '发撒的发生的发生', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000121', '28182694940871', '0', '00000000000000000013', '10', '40', '52', '韵达', '12', '否', null, '00000000000000000003', null, '支付宝', null, '2019-05-04 23:00:13', null, null, '00000000000000000010', '切尔奇翁人情味', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000122', '34479163868973', '0', '00000000000000000013', '4', '16', '31', '圆通', '15', '是', '00000000000000000053', '00000000000000000003', null, '支付宝', null, '2019-05-09 13:10:06', null, null, '00000000000000000010', '发酵收到货', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000123', '70766999236906', '0', '00000000000000000013', '5', '20', '36', '中通', '16', '否', null, '00000000000000000003', null, '支付宝', null, '2019-05-09 13:12:38', null, null, '00000000000000000010', '阿斯顿发送到', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000124', '40308048765843', '0', '00000000000000000013', '5', '20', '35', '圆通', '15', '是', '00000000000000000054', '00000000000000000003', null, '微信', null, '2019-05-09 13:14:44', null, null, '00000000000000000010', '欠人情翁', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000125', '92381425043396', '0', '00000000000000000013', '6', '24', '39', '圆通', '15', '是', '00000000000000000055', '00000000000000000003', null, '信用卡', null, '2019-05-09 13:22:52', null, null, '00000000000000000010', '我二条问题', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000126', '56136023471275', '1', '00000000000000000013', '6', '24', '39', '圆通', '15', '否', null, '00000000000000000003', null, '支付宝', '53668345448304', '2019-05-09 13:26:36', '2019-05-09 13:29:06', null, '00000000000000000010', '去玩儿', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000127', '58235915831545', '1', '00000000000000000013', '10', '40', '55', '圆通', '15', '是', '00000000000000000056', '00000000000000000003', null, '微信', '75372960712555', '2019-05-09 13:32:09', '2019-05-09 13:32:11', null, '00000000000000000010', '我儿去玩儿群', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000128', '92181319677480', '1', '00000000000000000013', '6', '24', '39', '圆通', '15', '是', '00000000000000000057', '00000000000000000003', null, '支付宝', '58130408861958', '2019-05-09 13:35:36', '2019-05-09 13:35:37', null, '00000000000000000010', '去玩儿群翁二群', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000129', '22212915533265', '1', '00000000000000000013', '8', '32', '47', '圆通', '15', '是', '00000000000000000058', '00000000000000000003', null, '信用卡', '55110245521750', '2019-05-09 13:36:45', '2019-05-09 13:36:47', null, '00000000000000000010', '撒的发生的', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000130', '98449776089536', '2', '00000000000000000010', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-05-09 20:07:17', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000131', '55650091481819', '2', '00000000000000000011', '1', '20000', '20000', null, null, null, null, null, null, '线下支付', null, '2019-05-09 20:07:18', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000132', '81024047736465', '2', '00000000000000000012', '1', '6699', '6699', null, null, null, null, null, null, '线下支付', null, '2019-05-09 20:07:19', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000133', '41251759888962', '2', '00000000000000000016', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-05-09 20:07:19', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000134', '67977548269844', '2', '00000000000000000015', '1', '55.3', '55.3', null, null, null, null, null, null, '线下支付', null, '2019-05-09 20:07:20', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000135', '43527831971389', '2', '00000000000000000014', '1', '79.8', '79.8', null, null, null, null, null, null, '线下支付', null, '2019-05-09 20:07:21', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000136', '54670623771779', '2', '00000000000000000020', '1', '1565', '1565', null, null, null, null, null, null, '线下支付', null, '2019-05-09 20:07:22', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000137', '11988568221327', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-05-09 20:07:23', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000138', '57122409259336', '2', '00000000000000000009', '1', '1999', '1999', null, null, null, null, null, null, '线下支付', null, '2019-05-09 20:07:24', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000139', '73802265269110', '2', '00000000000000000008', '1', null, null, null, null, null, null, null, null, '线下支付', null, '2019-05-09 20:07:25', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000140', '59558933169441', '2', '00000000000000000010', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-05-09 20:07:26', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000141', '10217202206775', '2', '00000000000000000011', '3', '60000', '60016', '中通', '16', '是', '00000000000000000059', '00000000000000000002', '00000000000000000033', '微信', '35100744984110', '2019-05-18 11:16:25', '2019-05-10 11:16:27', '2019-05-11 17:19:58', '00000000000000000009', '快点发货', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000142', '18120454124663', '1', '00000000000000000013', '6', '24', '39', '圆通', '15', '否', null, '00000000000000000002', null, '支付宝', '4202432523033', '2019-05-22 11:17:03', '2019-05-10 11:17:05', null, '00000000000000000009', '快点发货', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000143', '27948339781618', '2', '00000000000000000014', '1', '79.8', '79.8', null, null, null, null, null, null, '线下支付', null, '2019-05-10 11:17:56', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000144', '83777241406984', '2', '00000000000000000015', '1', '55.3', '55.3', null, null, null, null, null, null, '线下支付', null, '2019-05-10 11:17:58', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000145', '81346097545889', '2', '00000000000000000016', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-05-10 11:17:59', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000146', '59113211708366', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-05-10 11:18:00', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000147', '2212366405579', '2', '00000000000000000020', '1', '1565', '1565', null, null, null, null, null, null, '线下支付', null, '2019-05-10 11:18:02', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000148', '73892447750242', '2', '00000000000000000009', '1', '1999', '1999', null, null, null, null, null, null, '线下支付', null, '2019-05-10 11:18:03', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000149', '61686597981821', '2', '00000000000000000008', '1', null, null, null, null, null, null, null, null, '线下支付', null, '2019-05-10 11:18:05', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000150', '68943814123461', '2', '00000000000000000012', '1', '6699', '6699', null, null, null, null, null, null, '线下支付', null, '2019-05-21 11:18:05', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000151', '47586433781588', '2', '00000000000000000011', '1', '20000', '20000', null, null, null, null, null, null, '线下支付', null, '2019-05-20 11:18:06', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000152', '69540585909382', '2', '00000000000000000010', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-05-21 11:18:07', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000153', '50226634982514', '4', '00000000000000000008', '1', '1999', '2015', '中通', '16', '是', '00000000000000000060', '00000000000000000002', null, '微信', '44556295987853', '2019-05-11 13:12:34', '2019-05-11 13:12:36', null, '00000000000000000009', '阀打开链接画法几十块的话费卡', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000154', '65931817580924', '4', '00000000000000000013', '10', '40', '52', '韵达', '12', '否', null, '00000000000000000002', null, '信用卡', '44848861922276', '2019-05-22 13:13:07', '2019-05-11 13:13:08', null, '00000000000000000009', '发生了的积分徕卡三等奖', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000155', '58911818880177', '1', '00000000000000000011', '1', '20000', '20015', '圆通', '15', '是', '00000000000000000061', '00000000000000000002', null, '微信', '87254482805366', '2019-05-11 13:14:19', '2019-05-11 13:14:20', null, '00000000000000000009', '发上来看大家福利卡的', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000156', '42651983050381', '2', '00000000000000000011', '1', '20000', '20000', null, null, null, null, null, null, '线下支付', null, '2019-05-18 13:14:38', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000157', '76263510273424', '2', '00000000000000000010', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-05-19 13:14:40', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000158', '66725386527859', '2', '00000000000000000009', '1', '1999', '1999', null, null, null, null, null, null, '线下支付', null, '2019-05-11 13:14:41', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000159', '39789015857226', '2', '00000000000000000013', '1', '4', '4', null, null, null, null, null, null, '线下支付', null, '2019-05-20 13:14:42', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000160', '55075283123437', '2', '00000000000000000014', '1', '79.8', '79.8', null, null, null, null, null, null, '线下支付', null, '2019-05-18 13:14:43', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000161', '33680947992626', '2', '00000000000000000012', '1', '6699', '6699', null, null, null, null, null, null, '线下支付', null, '2019-05-22 13:14:44', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000162', '33914463819064', '2', '00000000000000000016', '1', '3799', '3799', null, null, null, null, null, null, '线下支付', null, '2019-05-21 13:14:46', null, null, null, null, null, null, '1');
INSERT INTO `order` VALUES ('00000000000000000163', '56116442822718', '1', '00000000000000000016', '1', '3799', '3811', '韵达', '12', '是', '00000000000000000062', '00000000000000000002', null, '信用卡', '42209184388592', '2019-05-18 13:15:05', '2019-05-11 13:15:06', null, '00000000000000000009', '阿斯顿发送到卡飞机', null, null, '0');
INSERT INTO `order` VALUES ('00000000000000000164', '50580072876462', '1', '00000000000000000011', '1', '20000', '20015', '圆通', '15', '是', '00000000000000000063', '00000000000000000003', null, '货到付款', '41036250254738', '2019-05-23 12:51:51', '2019-05-23 12:51:54', null, '00000000000000000010', '早发货', null, null, '0');

-- ----------------------------
-- Table structure for `order_invoice`
-- ----------------------------
DROP TABLE IF EXISTS `order_invoice`;
CREATE TABLE `order_invoice` (
  `invoice_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `order_id` int(20) unsigned zerofill NOT NULL,
  `invoice_no` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `addinvoice_time` datetime DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `order_invoice_order_id` (`order_id`),
  CONSTRAINT `order_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of order_invoice
-- ----------------------------
INSERT INTO `order_invoice` VALUES ('00000000000000000036', '00000000000000000049', null, '2019-03-31 14:17:56');
INSERT INTO `order_invoice` VALUES ('00000000000000000037', '00000000000000000050', null, '2019-04-01 22:30:12');
INSERT INTO `order_invoice` VALUES ('00000000000000000038', '00000000000000000052', null, '2019-04-03 13:10:39');
INSERT INTO `order_invoice` VALUES ('00000000000000000039', '00000000000000000054', null, '2019-04-03 23:27:53');
INSERT INTO `order_invoice` VALUES ('00000000000000000040', '00000000000000000059', null, '2019-04-04 16:49:33');
INSERT INTO `order_invoice` VALUES ('00000000000000000041', '00000000000000000060', null, '2019-04-04 16:56:26');
INSERT INTO `order_invoice` VALUES ('00000000000000000042', '00000000000000000069', null, '2019-04-15 23:03:45');
INSERT INTO `order_invoice` VALUES ('00000000000000000043', '00000000000000000069', null, '2019-04-15 23:03:45');
INSERT INTO `order_invoice` VALUES ('00000000000000000044', '00000000000000000086', null, '2019-04-16 22:45:02');
INSERT INTO `order_invoice` VALUES ('00000000000000000045', '00000000000000000087', null, '2019-04-16 22:45:47');
INSERT INTO `order_invoice` VALUES ('00000000000000000046', '00000000000000000088', null, '2019-04-16 22:47:15');
INSERT INTO `order_invoice` VALUES ('00000000000000000047', '00000000000000000104', null, '2019-04-17 13:05:29');
INSERT INTO `order_invoice` VALUES ('00000000000000000048', '00000000000000000106', null, '2019-04-17 13:07:02');
INSERT INTO `order_invoice` VALUES ('00000000000000000049', '00000000000000000106', null, '2019-04-17 13:07:02');
INSERT INTO `order_invoice` VALUES ('00000000000000000050', '00000000000000000116', null, '2019-04-28 17:43:22');
INSERT INTO `order_invoice` VALUES ('00000000000000000051', '00000000000000000117', null, '2019-05-04 21:38:15');
INSERT INTO `order_invoice` VALUES ('00000000000000000052', '00000000000000000118', null, '2019-05-04 22:38:44');
INSERT INTO `order_invoice` VALUES ('00000000000000000053', '00000000000000000122', null, '2019-05-09 13:10:06');
INSERT INTO `order_invoice` VALUES ('00000000000000000054', '00000000000000000124', null, '2019-05-09 13:14:44');
INSERT INTO `order_invoice` VALUES ('00000000000000000055', '00000000000000000125', null, '2019-05-09 13:22:52');
INSERT INTO `order_invoice` VALUES ('00000000000000000056', '00000000000000000127', null, '2019-05-09 13:32:09');
INSERT INTO `order_invoice` VALUES ('00000000000000000057', '00000000000000000128', null, '2019-05-09 13:35:36');
INSERT INTO `order_invoice` VALUES ('00000000000000000058', '00000000000000000129', null, '2019-05-09 13:36:45');
INSERT INTO `order_invoice` VALUES ('00000000000000000059', '00000000000000000141', null, '2019-05-10 11:16:25');
INSERT INTO `order_invoice` VALUES ('00000000000000000060', '00000000000000000153', null, '2019-05-11 13:12:35');
INSERT INTO `order_invoice` VALUES ('00000000000000000061', '00000000000000000155', null, '2019-05-11 13:14:19');
INSERT INTO `order_invoice` VALUES ('00000000000000000062', '00000000000000000163', null, '2019-05-11 13:15:05');
INSERT INTO `order_invoice` VALUES ('00000000000000000063', '00000000000000000164', null, '2019-05-23 12:51:51');

-- ----------------------------
-- Table structure for `order_logistics`
-- ----------------------------
DROP TABLE IF EXISTS `order_logistics`;
CREATE TABLE `order_logistics` (
  `order_logistics_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `order_id` int(20) unsigned zerofill NOT NULL,
  `express_no` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_logistics` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `logistics_fee` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_logistics_status` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `logistics_result_last` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logistics_result` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delivery_time` datetime DEFAULT NULL,
  `logistics_update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`order_logistics_id`),
  KEY `order_logistics_order_id` (`order_id`),
  CONSTRAINT `order_logistics_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of order_logistics
-- ----------------------------
INSERT INTO `order_logistics` VALUES ('00000000000000000024', '00000000000000000049', '39639636554501', '中通', '16', null, null, null, '2019-04-01 23:12:49', null);
INSERT INTO `order_logistics` VALUES ('00000000000000000025', '00000000000000000051', '66497644997318', '中通', '16', null, null, null, '2019-04-03 13:02:00', null);
INSERT INTO `order_logistics` VALUES ('00000000000000000026', '00000000000000000050', '47106667233624', '顺丰', '20', null, null, null, '2019-04-03 13:03:20', null);
INSERT INTO `order_logistics` VALUES ('00000000000000000027', '00000000000000000053', '61641022912050', null, null, null, null, null, '2019-04-04 16:26:57', null);
INSERT INTO `order_logistics` VALUES ('00000000000000000028', '00000000000000000054', '39515930090590', '圆通', '15', null, null, null, '2019-04-04 16:27:04', null);
INSERT INTO `order_logistics` VALUES ('00000000000000000029', '00000000000000000088', '28992482695371', '顺丰', '20', null, null, null, '2019-04-16 23:02:34', null);
INSERT INTO `order_logistics` VALUES ('00000000000000000030', '00000000000000000088', '53391931328473', '顺丰', '20', null, null, null, '2019-04-16 23:02:34', null);
INSERT INTO `order_logistics` VALUES ('00000000000000000031', '00000000000000000087', '53858754427644', '中通', '16', null, null, null, '2019-04-16 23:03:34', null);
INSERT INTO `order_logistics` VALUES ('00000000000000000032', '00000000000000000116', '21663837949371', '中通', '16', null, null, null, '2019-04-28 17:45:02', null);
INSERT INTO `order_logistics` VALUES ('00000000000000000033', '00000000000000000141', '75101821708424', '中通', '16', null, null, null, '2019-05-11 17:19:58', null);
INSERT INTO `order_logistics` VALUES ('00000000000000000034', '00000000000000000069', '62804704802379', '韵达', '12', null, null, null, '2019-05-24 23:09:38', null);

-- ----------------------------
-- Table structure for `order_returns`
-- ----------------------------
DROP TABLE IF EXISTS `order_returns`;
CREATE TABLE `order_returns` (
  `order_returns_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `returns_no` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `order_id` int(20) unsigned zerofill NOT NULL,
  `return_reason` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `return_time` datetime DEFAULT NULL,
  `ishandle` char(2) COLLATE utf8_unicode_ci DEFAULT '0',
  PRIMARY KEY (`order_returns_id`),
  KEY `return_order_id` (`order_id`),
  CONSTRAINT `return_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of order_returns
-- ----------------------------
INSERT INTO `order_returns` VALUES ('00000000000000000001', '76794770561006', '00000000000000000154', '太多喝不完', '2019-05-11 15:15:50', '0');
INSERT INTO `order_returns` VALUES ('00000000000000000002', '14179351746509', '00000000000000000049', '', '2019-05-23 11:59:43', '0');

-- ----------------------------
-- Table structure for `supplier`
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `supplier_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `supplier_contact` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `supplier_address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `supplier_postcode` char(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `supplier_tel` char(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `supplier_email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `supplier_bank` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `supplier_account` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES ('00000000000000000007', '戴尔', '胡建国', '湖北省武汉市江汉区江汉路步行街中心百货中百商厦19楼05号戴尔维修服务中心', '430015', '15623458965', 'hubeidell@163.com', '中国人民银行', '456895623456895');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `user_avatar` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `real_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_tel` char(11) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_email` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_password` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `regist_time` datetime DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `isadmin` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `statistics` int(10) DEFAULT '0',
  `last_login_time` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('00000000000000000001', '../../static/image/IMG_20180325_112211.jpg', '任国峰', '中南民族大学', '17191194345', '1032387871@qq.com', 'rgf19951011', '2019-03-14 12:36:11', '2019-03-18 08:27:29', '2', null, '2019-03-25 09:47:51');
INSERT INTO `user` VALUES ('00000000000000000008', '../../static/image/avatar.png', null, 'csm15946856865', '15946856865', 'fasdfasd@qq.com', '123456', '2019-03-19 11:41:43', null, '0', null, null);
INSERT INTO `user` VALUES ('00000000000000000009', '../../static/image/avatar.png', null, 'csmadmin', 'admin', 'admin@qq.com', 'admin', '2019-03-25 09:24:43', null, '2', null, '2019-05-13 14:17:59');
INSERT INTO `user` VALUES ('00000000000000000010', '../../static/image/avatar.png', null, 'csm13648268384', '13648268384', '1032387871@qq.com', '123456', '2019-03-26 11:52:04', null, '2', null, '2019-05-24 22:54:47');
INSERT INTO `user` VALUES ('00000000000000000011', '../../static/image/avatar.png', null, 'csm15678959456', '15678959456', '1235546542@qq.com', 'rgf19951011', '2019-05-13 14:23:13', null, '0', '0', null);
INSERT INTO `user` VALUES ('00000000000000000013', '../../static/image/avatar.png', null, 'csm15945896548', '15945896548', '1515644546@qq.com', '123456', '2019-05-24 22:52:58', null, '0', '0', null);

-- ----------------------------
-- Table structure for `warehousing`
-- ----------------------------
DROP TABLE IF EXISTS `warehousing`;
CREATE TABLE `warehousing` (
  `warehousing_id` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `warehousing_order_id` int(20) DEFAULT NULL,
  `warehousing_time` datetime DEFAULT NULL,
  `goods_id` int(20) unsigned zerofill DEFAULT NULL,
  `warehousing_count` int(5) DEFAULT NULL,
  `total_price` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `warehousing_staff` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `supplier` int(20) unsigned zerofill NOT NULL,
  PRIMARY KEY (`warehousing_id`),
  KEY `warehousing_supplier` (`supplier`),
  KEY `warehousing_goods_id` (`goods_id`),
  CONSTRAINT `warehousing_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of warehousing
-- ----------------------------
INSERT INTO `warehousing` VALUES ('00000000000000000013', '1234568965', '2019-04-01 17:39:00', '00000000000000000011', '100', '1800000', '胡建国', '00000000000000000007');
