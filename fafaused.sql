/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 50562
 Source Host           : localhost:3306
 Source Schema         : secondhandmarket

 Target Server Type    : MySQL
 Target Server Version : 50562
 File Encoding         : 65001

 Date: 18/04/2020 14:23:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `phone` bigint(25) NOT NULL,
  `password` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `userRole` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'jiali', 123456, '123456', '超级管理员');
INSERT INTO `admin` VALUES (2, '宋乾炜', 15037752845, '222222', 'root');

-- ----------------------------
-- Table structure for catelog
-- ----------------------------
DROP TABLE IF EXISTS `catelog`;
CREATE TABLE `catelog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名',
  `number` int(11) NULL DEFAULT 0 COMMENT '该分类下的商品数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of catelog
-- ----------------------------
INSERT INTO `catelog` VALUES (1, '闲置数码', 11);
INSERT INTO `catelog` VALUES (2, '校园代步', 1);
INSERT INTO `catelog` VALUES (3, '电器日用', 3);
INSERT INTO `catelog` VALUES (4, '图书教材', 7);
INSERT INTO `catelog` VALUES (5, '美妆衣物', 10);
INSERT INTO `catelog` VALUES (6, '运动棋牌', 2);
INSERT INTO `catelog` VALUES (7, '票券小物', 11);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论主键',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户，外键',
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品，外键',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `create_at` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 138 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (120, 8, 97, '厉害厉害~', '2020-02-04 01:38:13');
INSERT INTO `comments` VALUES (121, 3, 77, '1212', '2020-02-04 01:38:13');
INSERT INTO `comments` VALUES (122, 6, 90, '111', '2020-02-04 01:38:13');
INSERT INTO `comments` VALUES (123, 1, 103, '喜欢排球', '2020-02-04 01:38:13');
INSERT INTO `comments` VALUES (124, 1, 20, '不知道用了多久了', '2020-02-04 01:38:13');
INSERT INTO `comments` VALUES (125, 1, 110, '自己看过，很不错的一本书 。', '2020-02-04 01:38:13');
INSERT INTO `comments` VALUES (126, 1, 107, 'HHH', '2020-02-04 01:38:19');
INSERT INTO `comments` VALUES (127, 1, 5, '黄淮', '2020-01-16 04:28:40');
INSERT INTO `comments` VALUES (128, 1, 5, '好看', '2020-01-16 04:28:55');
INSERT INTO `comments` VALUES (129, 1, 6, '黄淮', '2020-01-16 04:29:20');
INSERT INTO `comments` VALUES (130, 1, 79, '黄淮', '2020-02-04 01:37:45');
INSERT INTO `comments` VALUES (131, 1, 79, '好看', '2020-02-04 01:37:57');
INSERT INTO `comments` VALUES (132, 1, 79, '0909090', '2020-02-04 01:38:13');
INSERT INTO `comments` VALUES (133, 1, 148, '0909090', '2020-04-11 10:15:09');
INSERT INTO `comments` VALUES (134, 1, 148, '好看', '2020-04-11 10:15:14');
INSERT INTO `comments` VALUES (135, 1, 162, '0909090', '2020-04-11 11:28:49');
INSERT INTO `comments` VALUES (136, 1, 141, '123', '2020-04-17 02:49:42');
INSERT INTO `comments` VALUES (137, 1, 141, '555', '2020-04-17 02:49:58');

-- ----------------------------
-- Table structure for focus
-- ----------------------------
DROP TABLE IF EXISTS `focus`;
CREATE TABLE `focus`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '外键 商品id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '外键 用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of focus
-- ----------------------------
INSERT INTO `focus` VALUES (27, 123, 1);
INSERT INTO `focus` VALUES (29, 162, 1);
INSERT INTO `focus` VALUES (30, 141, 2);
INSERT INTO `focus` VALUES (31, 165, 2);
INSERT INTO `focus` VALUES (32, 151, 2);
INSERT INTO `focus` VALUES (33, 152, 2);
INSERT INTO `focus` VALUES (34, 153, 2);
INSERT INTO `focus` VALUES (35, 154, 2);
INSERT INTO `focus` VALUES (36, 155, 2);
INSERT INTO `focus` VALUES (37, 144, 1);
INSERT INTO `focus` VALUES (38, 123, 35);
INSERT INTO `focus` VALUES (39, 123, 3);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品主键',
  `catelog_id` int(11) NULL DEFAULT NULL COMMENT '商品分类，外键',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户外键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `price` float(11, 2) NULL DEFAULT NULL COMMENT '出售价格',
  `real_price` float(11, 2) NULL DEFAULT NULL COMMENT '真实价格',
  `start_time` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布时间',
  `polish_time` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '擦亮时间，按该时间进行查询，精确到时分秒',
  `end_time` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '下架时间',
  `describle` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '详细信息',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态 上架1 下架0',
  `heatnum` int(11) NULL DEFAULT 0 COMMENT '商品热度',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `catelog_id`(`catelog_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 166 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (79, 1, 1, '出HTC M9ET 3+32G', 1500.00, 2888.00, '2020-02-03', '2020-02-03', '2020-02-03', '自用，自认为九成新，除了边角磕碰，其他都好，无暗病', 1, 1);
INSERT INTO `goods` VALUES (80, 1, 1, '二手苹果iphone6 6s', 2488.00, 4888.00, '2020-02-03', '2020-02-03', '2020-02-03', '无锁 支持三网4G 成色9-99新 优先下单优先挑选靓成色发货 主板无限 无暗病 功能全部正常 诚信经营 以上均64G 需其他机型可私聊', 1, 0);
INSERT INTO `goods` VALUES (82, 2, 1, '二手 电动车', 1700.00, 2580.00, '2020-02-03', '2020-02-03', '2020-02-03', '羽铃电动车，购于2017年9月，个人原因想出，原价2850，现在二手出1700可刀，证牌齐全自用车，左后方车轮防护板断裂(如图)，车前头购买的时候就有划痕因为不影响使用就没叫老板换新的，一切破损不影响使用。', 1, 0);
INSERT INTO `goods` VALUES (83, 2, 1, '全新山地车', 398.00, 498.00, '2020-02-03', '2020-02-03', '2020-02-03', '自身原因起不了。全新山地车特价：现价380元，原价498元，21速碟刹加厚铝合金轮子', 1, 0);
INSERT INTO `goods` VALUES (84, 3, 1, '低价出售空调，', 800.00, 1846.00, '2020-02-03', '2020-02-03', '2020-02-03', '13年购入的长虹空调，加了2米铜管，1匹冷暖型', 1, 0);
INSERT INTO `goods` VALUES (85, 3, 1, '出手吹风机', 15.00, 35.00, '2020-02-03', '2020-02-03', '2020-02-03', '头发剪短了，现在不需要了，低价出售', 1, 0);
INSERT INTO `goods` VALUES (86, 3, 1, '单板吉他', 688.00, 1200.00, '2020-02-03', '2020-02-03', '2020-02-03', '单板原价1200，买了两年了，弹过一个多月就搁置，毕业季出了。赠书三月通（30），赠一套弦（30）.', 1, 0);
INSERT INTO `goods` VALUES (87, 7, 1, '迪丽热巴', 10.00, 12.00, '2020-02-03', '2020-02-03', '2020-02-03', '德国进口彩铅辉柏嘉，48色淘宝在60左右，我的买过来画了几张画就闲置了，彩票效果相当好，黑色用得比较快还剩一半多了', 1, 0);
INSERT INTO `goods` VALUES (88, 2, 1, '九成新仰卧板 ', 50.00, 150.00, '2020-02-03', '2020-02-03', '2020-02-03', '没用多少次 带不走便宜卖了', 1, 0);
INSERT INTO `goods` VALUES (89, 4, 1, '艺乐杨幂刊', 20.00, 68.00, '2020-02-03', '2020-02-03', '2020-02-03', '艺乐杂志 杨幂专刊 走进偶像 了解偶像背后的故事', 1, 0);
INSERT INTO `goods` VALUES (91, 4, 1, '刘语熙《我遇见我》', 25.00, 55.00, '2020-02-03', '2020-02-03', '2020-02-03', '“乌贼刘”刘语熙自传我遇见我 讲述追梦历程', 1, 0);
INSERT INTO `goods` VALUES (92, 5, 1, '灰色短袖', 12.00, 30.00, '2020-02-03', '2020-02-03', '2020-02-03', '刚买的，全新 全新 全新', 1, 0);
INSERT INTO `goods` VALUES (93, 5, 1, '帽子', 10.00, 25.00, '2020-02-03', '2020-02-03', '2020-02-03', '买戴过', 1, 0);
INSERT INTO `goods` VALUES (94, 3, 1, '烧水壶', 22.00, 50.00, '2020-02-03', '2020-02-03', '2020-02-03', '烧水壶功能一切都好，请放心使用', 1, 0);
INSERT INTO `goods` VALUES (95, 3, 1, '桌面吸尘器', 28.00, 59.00, '2020-02-03', '2020-02-03', '2020-02-03', '桌面吸尘器，可以清洁键盘、吸纸屑、头发、灰尘，有蓝色和白色两款', 1, 0);
INSERT INTO `goods` VALUES (96, 7, 1, '纯手工绘画，来图定制，提供绘画过程图，追女友神器', 108.00, NULL, '2020-02-03', '2020-02-03', '2020-02-03', '纯手工绘画，来图定制，提供绘画过程，实木相框装裱，A4大小与12寸，64801606', 1, 0);
INSERT INTO `goods` VALUES (103, 6, 1, '排球', 110.00, 200.00, '2020-02-03', '2020-02-03', '2020-02-03', '9成新', 1, 0);
INSERT INTO `goods` VALUES (106, 5, 1, '资生堂金瓶防晒霜', 50.00, 260.00, '2020-02-03', '2020-02-03', '2020-02-03', '夏天必不可少的一款防晒霜，真的晒不黑哦。', 1, 0);
INSERT INTO `goods` VALUES (107, 5, 1, '露得清防晒喷雾', 40.00, 110.00, '2020-02-03', '2020-02-03', '2020-02-03', '很方便的防晒喷雾，可以随身携带，随时喷一喷。而且这款喷雾很清爽，一点也不油腻。', 1, 0);
INSERT INTO `goods` VALUES (108, 7, 1, '太阳镜', 10.00, 30.00, '2020-02-03', '2020-02-03', '2020-02-03', '可以用来遮阳的', 1, 0);
INSERT INTO `goods` VALUES (109, 7, 1, '傲滴 隐形眼镜护理液', 30.00, 60.00, '2020-02-03', '2020-02-03', '2020-02-03', '一款超级舒服的隐形眼镜护理液。', 1, 0);
INSERT INTO `goods` VALUES (110, 4, 1, '《我们仨》杨绛', 10.00, 17.00, '2020-02-03', '2020-02-03', '2020-02-03', '杨先生对他们家三人的记录。', 1, 0);
INSERT INTO `goods` VALUES (111, 4, 1, '《一切都是最好的安排》加措', 10.00, 20.00, '2020-02-03', '2020-02-03', '2020-02-03', '诗人仓央嘉措的书，很美。', 1, 0);
INSERT INTO `goods` VALUES (122, 2, 1, '山地车', 99.00, 160.00, '2020-02-03', '2020-02-03', '2020-02-03', '九成新，自己在学校骑，毕业甩', 1, 0);
INSERT INTO `goods` VALUES (123, 3, 1, '吉他', 10.00, 160.00, '2020-02-03', '2020-02-03', '2020-02-03', '吉他，妹子撩到啦，陪妹子事情多 现出手', 1, 2);
INSERT INTO `goods` VALUES (124, 1, 1, '罗技鼠标', 999.00, 160.00, '2020-02-03', '2020-02-03', '2020-02-03', '罗技牛逼 现出手', 1, 0);
INSERT INTO `goods` VALUES (125, 1, 1, '佳能相机', 10.00, 12.00, '2020-02-03', '2020-02-03', '2020-02-03', '佳能常在 感动常在', 1, 0);
INSERT INTO `goods` VALUES (126, 1, 1, '华硕 飞行堡垒', 999.00, 6660.00, '2020-02-03', '2020-02-03', '2020-02-03', '吃鸡无压力', 1, 0);
INSERT INTO `goods` VALUES (127, 7, 1, '储物架', 99.00, 123.00, '2020-02-03', '2020-02-03', '2020-02-03', '小巧方便', 1, 0);
INSERT INTO `goods` VALUES (128, 3, 1, '台灯', 200.00, 6660.00, '2020-02-03', '2020-02-03', '2020-02-03', '台灯  伴你复习的每一个寂寞的夜晚', 1, 0);
INSERT INTO `goods` VALUES (129, 6, 1, '回力球鞋', 99.00, 999.00, '2020-02-03', '2020-02-03', '2020-02-03', '回力  国产之光 九成新  可面议', 1, 0);
INSERT INTO `goods` VALUES (130, 1, 1, 'bb机', 200.00, 777.00, '2020-02-03', '2020-02-03', '2020-02-03', 'bb机   时代感  是买不到的', 1, 0);
INSERT INTO `goods` VALUES (131, 5, 1, '女包', 200.00, 999.00, '2020-02-03', '2020-02-03', '2020-02-03', '女包  七成新  陪我度过四年的大学时光  迫不得已出手', 1, 0);
INSERT INTO `goods` VALUES (132, 5, 1, '耐克包', 200.00, 333.00, '2020-02-03', '2020-02-03', '2020-02-03', '耐克  吊', 1, 0);
INSERT INTO `goods` VALUES (133, 5, 1, '子母包', 99.00, 123.00, '2020-02-03', '2020-02-03', '2020-02-03', '大小两个包哦  买不了吃亏', 1, 0);
INSERT INTO `goods` VALUES (134, 4, 1, '盗墓笔记全集', 99.00, 555.00, '2020-02-03', '2020-02-03', '2020-02-03', '盗墓笔记  懂得来', 1, 0);
INSERT INTO `goods` VALUES (135, 4, 1, '教师资格资料', 99.00, 160.00, '2020-02-03', '2020-02-03', '2020-02-03', '教师资料  含真题', 1, 0);
INSERT INTO `goods` VALUES (136, 1, 1, '联想  拯救者', 999.00, 6666.00, '2020-02-03', '2020-02-03', '2020-02-03', '拯救者  吃鸡的不二选择', 1, 0);
INSERT INTO `goods` VALUES (137, 2, 1, '滑板', 10.00, 999.00, '2020-02-04', '2020-02-04', '2020-02-14', '哇哈哈', 0, 0);
INSERT INTO `goods` VALUES (138, 7, 1, '浪琴手表', 130.00, 6660.00, '2020-02-04', '2020-02-04', '2020-02-14', '手表七成新  转', 1, 0);
INSERT INTO `goods` VALUES (139, 3, 1, '路由器', 10.00, 6660.00, '2020-02-04', '2020-02-04', '2020-02-14', '路由器  毕业 转  学弟合眼缘免费送', 0, 0);
INSERT INTO `goods` VALUES (140, 5, 1, '礼服', 10.00, 123.00, '2020-02-04', '2020-02-04', '2020-02-14', 'dqwd', 1, 0);
INSERT INTO `goods` VALUES (141, 7, 1, '毛绒熊', 99.00, 999.00, '2020-02-04', '2020-02-04', '2020-02-14', '舔狗送的  便宜出', 1, 1);
INSERT INTO `goods` VALUES (142, 2, 1, '摩托', 200.00, 12.00, '2020-02-04', '2020-02-04', '2020-02-14', '摩托  拉风', 1, 0);
INSERT INTO `goods` VALUES (143, 3, 1, '饮水机', 999.00, 999.00, '2020-02-04', '2020-02-04', '2020-02-14', '毕业出', 1, 0);
INSERT INTO `goods` VALUES (144, 1, 1, '蓝牙音箱', 99.00, 777.00, '2020-02-04', '2020-02-04', '2020-02-14', '便宜出', 1, 1);
INSERT INTO `goods` VALUES (145, 5, 1, '登山包', 200.00, 123.00, '2020-02-04', '2020-02-04', '2020-02-14', '新的  没用过', 1, 0);
INSERT INTO `goods` VALUES (146, 3, 1, '寝室柜子', 10.00, 12.00, '2020-02-04', '2020-02-04', '2020-02-14', '用着  超爽', 1, 0);
INSERT INTO `goods` VALUES (147, 2, 1, '山地车', 10.00, 777.00, '2020-02-04', '2020-02-04', '2020-02-14', '很少骑行   买的 闲置 很久  便宜出', 1, 0);
INSERT INTO `goods` VALUES (148, 1, 1, '相机', 130.00, 123.00, '2020-02-04', '2020-02-04', '2020-02-14', '老婆不让玩  很费钱', 1, 0);
INSERT INTO `goods` VALUES (149, 1, 1, '考试笔', 999.00, 6660.00, '2020-02-04', '2020-02-04', '2020-02-14', '考试用  超爽  好吧   我就是卖笔的', 1, 0);
INSERT INTO `goods` VALUES (150, 1, 1, '手机适配耳机', 99.00, 777.00, '2020-02-04', '2020-02-04', '2020-02-14', '耳机 自用 有磕碰', 1, 0);
INSERT INTO `goods` VALUES (151, 7, 1, '土狗', 130.00, 12.00, '2020-02-04', '2020-02-04', '2020-02-14', '学校不让养', 1, 0);
INSERT INTO `goods` VALUES (152, 5, 1, '平时穿衣服', 99.00, 999.00, '2020-02-04', '2020-02-04', '2020-02-14', '衣服', 1, 0);
INSERT INTO `goods` VALUES (153, 6, 1, '高跟鞋', 130.00, 6660.00, '2020-02-04', '2020-02-04', '2020-02-14', '高跟鞋', 1, 0);
INSERT INTO `goods` VALUES (154, 7, 1, '带线耳机', 99.00, 160.00, '2020-02-04', '2020-02-04', '2020-02-14', '带线耳机 全新', 1, 0);
INSERT INTO `goods` VALUES (155, 4, 1, '专业书', 99.00, 123.00, '2020-02-04', '2020-02-04', '2020-02-14', '专业书  计算机专业 学弟可用 价格 好说', 1, 0);
INSERT INTO `goods` VALUES (156, 7, 1, '暴龙眼镜', 1.00, 160.00, '2020-02-04', '2020-02-04', '2020-02-14', '太阳镜', 1, 0);
INSERT INTO `goods` VALUES (157, 6, 1, '足球', 1.00, 999.00, '2020-02-05', '2020-02-05', '2020-02-15', '国足太烂了 心碎 不想再提了', 0, 0);
INSERT INTO `goods` VALUES (158, 6, 1, '羽毛球器材', 1.00, 123.00, '2020-02-05', '2020-02-05', '2020-02-15', '碳钢材质 轻便有力  不易折断 不二选择', 0, 0);
INSERT INTO `goods` VALUES (159, 6, 1, '羽毛球', 1.00, 6660.00, '2020-02-05', '2020-02-05', '2020-02-15', '买球送一副球拍   划算的紧呐', 0, 0);
INSERT INTO `goods` VALUES (160, 6, 1, '象棋', 99.00, 777.00, '2020-02-05', '2020-02-05', '2020-02-15', '买棋子  送棋盘  买不了吃亏 买不了上当', 0, 0);
INSERT INTO `goods` VALUES (161, 6, 1, 'fafa', 1.00, 12.00, '2020-02-05', '2020-02-05', '2020-02-15', '围棋  喜欢的来', 0, 0);
INSERT INTO `goods` VALUES (162, 6, 1, '乒乓球', 99.00, 777.00, '2020-02-05', '2020-02-05', '2020-02-15', '高端的球拍  懂得来 不动勿扰 学长很忙', 1, 1);
INSERT INTO `goods` VALUES (163, 3, 1, '123', 10.00, 123.00, '2020-04-11', '2020-04-11', '2020-04-21', '测试第一次', 1, 0);
INSERT INTO `goods` VALUES (164, 7, 1, '测试发布', 99.00, 123.00, '2020-04-11', '2020-04-11', '2020-04-21', '测试第一次', 0, 0);
INSERT INTO `goods` VALUES (165, 1, 1, '测试发布', 1.00, 160.00, '2020-04-11', '2020-04-11', '2020-04-21', '测试第一次发布', 1, 1);

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图片主键',
  `goods_id` int(11) NOT NULL COMMENT '商品外键',
  `img_url` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片链接',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goods_id`(`goods_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 171 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES (21, 77, '4f320b75-427a-484e-b725-a2f5d066af6f.jpg');
INSERT INTO `image` VALUES (78, 78, '599629aa-9440-435c-8185-42e34a862470.jpg');
INSERT INTO `image` VALUES (79, 79, '266abea1-a202-47f2-b5c4-095e96c10473.jpg');
INSERT INTO `image` VALUES (80, 80, '4d472617-d430-4540-a510-f7606861dde0.jpg');
INSERT INTO `image` VALUES (81, 81, 'e62acc43-8122-421a-940b-a68e6aeadd30.jpg');
INSERT INTO `image` VALUES (82, 82, '67a5f2ee-a09a-488d-9e7a-87ac6d8ab9c4.jpg');
INSERT INTO `image` VALUES (83, 83, '110456d4-cc20-4fe2-b0a6-217b023d7dd6.jpg');
INSERT INTO `image` VALUES (84, 84, '499afa59-53bc-4d23-99ef-5d0f9d60de69.jpg');
INSERT INTO `image` VALUES (85, 85, '23f242e3-6dbf-4d46-a1b2-a620918908d9.jpg');
INSERT INTO `image` VALUES (86, 86, 'ae1097a5-736d-4850-9552-b5901ad6d84b.jpg');
INSERT INTO `image` VALUES (87, 87, '95daa308-8011-4e0c-b5bd-8cd151830c32.jpg');
INSERT INTO `image` VALUES (88, 88, '5c212d57-d8a4-4cc0-8853-dba957fba3d5.jpg');
INSERT INTO `image` VALUES (89, 89, 'ec5369f6-7c87-43db-98aa-112efa91c8c6.JPG');
INSERT INTO `image` VALUES (90, 90, 'fd680315-9ac8-4268-803e-7da7b492e8b0.JPG');
INSERT INTO `image` VALUES (91, 91, '455e9ee5-92a7-4c7c-aa94-55f4373a16ee.JPG');
INSERT INTO `image` VALUES (92, 92, '33434fa2-8bf3-4fbc-b1d9-d1e67202e2f2.jpg');
INSERT INTO `image` VALUES (93, 93, 'dc4f9591-bd1a-4eac-b1ea-be6412296fb6.png');
INSERT INTO `image` VALUES (94, 94, '7eb89aaa-56c0-4283-893f-bd5718301d80.jpg');
INSERT INTO `image` VALUES (95, 95, '6664b320-87d4-4d37-b14f-fc5dba41f529.PNG');
INSERT INTO `image` VALUES (96, 96, '451c3aa2-529d-449d-b69f-b8771af1d806.jpg');
INSERT INTO `image` VALUES (97, 97, 'ee6e735c-6479-40bb-b45f-69888c42862e.jpg');
INSERT INTO `image` VALUES (98, 98, '2f92136b-af5b-45f4-902d-7bb1d0ad0809.png');
INSERT INTO `image` VALUES (99, 99, '022fe88a-5328-4b42-8333-10b782d39373.png');
INSERT INTO `image` VALUES (100, 100, 'a1f11b39-490b-42ef-a8e1-44285c4a80d4.png');
INSERT INTO `image` VALUES (101, 101, '0f022547-b2cb-45fe-ab86-fb8b6d70adbc.jpg');
INSERT INTO `image` VALUES (103, 103, 'b0933eb3-1ccb-43e1-80a4-1d50902916db.jpg');
INSERT INTO `image` VALUES (105, 105, '504d47df-32b0-4195-b63c-10d1562896cc.jpg');
INSERT INTO `image` VALUES (106, 106, 'a634ca2b-70cc-404d-95cb-fc4166fe6706.jpg');
INSERT INTO `image` VALUES (107, 107, '1ba8f318-fbf3-42f6-b8d9-0baa7e678cec.jpg');
INSERT INTO `image` VALUES (108, 108, '8ad2130e-b4bc-40aa-a1ea-e0d9fb66dd2ephoto5.jpg');
INSERT INTO `image` VALUES (109, 109, '330a9a46-6434-4d04-a72b-a91a14035229.jpg');
INSERT INTO `image` VALUES (110, 110, '0583cb1e-6acd-46da-bebc-4a9f1d6c3ac7.jpg');
INSERT INTO `image` VALUES (111, 111, '660d1589-2f20-4362-ab45-38d9f8cd2c58nopic17.png');
INSERT INTO `image` VALUES (112, 112, '854dff80-d049-4381-ae40-d1d23cd0e88b.jpg');
INSERT INTO `image` VALUES (116, 117, '7994b9b7-7479-4cda-b549-ce1b3c1636belogo.jpg');
INSERT INTO `image` VALUES (118, 119, '59c84c5d-2def-4582-b9a6-21d42e768ec1');
INSERT INTO `image` VALUES (119, 120, '6d542b9b-c895-42ef-bf45-63cc16b5737bIMG_20190115_201658.jpg');
INSERT INTO `image` VALUES (120, 121, '72529e2d-fadf-4dae-a2c1-e7d449c34ac3IMG_20190115_201658.jpg');
INSERT INTO `image` VALUES (121, 111, '660d1589-2f20-4362-ab45-38d9f8cd2c58nopic17.png');
INSERT INTO `image` VALUES (122, 111, '660d1589-2f20-4362-ab45-38d9f8cd2c58nopic17.png');
INSERT INTO `image` VALUES (123, 111, '660d1589-2f20-4362-ab45-38d9f8cd2c58nopic17.png');
INSERT INTO `image` VALUES (124, 111, '660d1589-2f20-4362-ab45-38d9f8cd2c58nopic17.png');
INSERT INTO `image` VALUES (125, 108, '8ad2130e-b4bc-40aa-a1ea-e0d9fb66dd2ephoto5.jpg');
INSERT INTO `image` VALUES (126, 111, '660d1589-2f20-4362-ab45-38d9f8cd2c58nopic17.png');
INSERT INTO `image` VALUES (127, 122, 'ecb3a327-2acf-4950-bab7-0c431d6873d1nopic2.png');
INSERT INTO `image` VALUES (128, 123, 'ed93550e-2f4f-4384-b6a0-3a4b3ef93499nopic1.png');
INSERT INTO `image` VALUES (129, 124, '91a45b59-928b-43fe-a5ca-38fce8832bbcnopic3.png');
INSERT INTO `image` VALUES (130, 125, '6c12ae8c-2a68-4fbd-81c8-3900ae08a954nopic5.png');
INSERT INTO `image` VALUES (131, 126, 'd93beb1f-09ed-4ed1-b9ea-29779417c7afnopic6.png');
INSERT INTO `image` VALUES (132, 127, 'e9b0ecfb-122d-4e51-8465-12f24e2623b2nopic7.png');
INSERT INTO `image` VALUES (133, 128, 'f61703cf-99f4-4872-8109-c7bef6161c95nopic8.png');
INSERT INTO `image` VALUES (134, 129, '69ad71ee-d105-4f47-88f3-d46166d2f733nopic9.png');
INSERT INTO `image` VALUES (135, 130, 'ae27e45f-926c-4386-a6cb-f441c025935cnopic11.png');
INSERT INTO `image` VALUES (136, 131, '90fc85f6-4885-45bd-b9d8-d422d8165cb3nopic12.png');
INSERT INTO `image` VALUES (137, 132, '3406a570-59cc-4849-8569-bfc1956d8119nopic16.png');
INSERT INTO `image` VALUES (138, 133, '2c56cd72-a402-43c0-8a7d-f15ea4225efdnopic13.png');
INSERT INTO `image` VALUES (139, 134, 'b44719c1-e7cd-4f85-95ee-c89c72e12458nopic17.png');
INSERT INTO `image` VALUES (140, 135, 'dc061dfc-893c-4e3d-99fb-27ea2db48bb1nopic18.png');
INSERT INTO `image` VALUES (141, 136, 'fd43f316-c888-499b-a729-3863a69bcf9anopic20.png');
INSERT INTO `image` VALUES (142, 137, '9f08124a-aa60-4cf4-a847-7003776c9a165.jpg');
INSERT INTO `image` VALUES (143, 138, '80800317-9463-4781-ba3e-15c19d7e49ac64.jpg');
INSERT INTO `image` VALUES (144, 139, '7946d16e-1a63-42fd-bd55-4a26221e577954.jpg');
INSERT INTO `image` VALUES (145, 140, '7b0e188d-ee75-42c0-9450-0908715f86e576.jpg');
INSERT INTO `image` VALUES (146, 141, '669c30df-5efb-4ebf-a5e8-56a3cb85a1ef646.jpg');
INSERT INTO `image` VALUES (147, 142, '1a0c77cf-fab2-4a02-8e56-3f784b74e9f4565.jpg');
INSERT INTO `image` VALUES (148, 143, 'c2eaf5f0-ec76-4d2a-bff6-ed799da3a78a576.jpg');
INSERT INTO `image` VALUES (149, 144, '4e5c3776-7387-4a10-bc76-7cf2f6dfe517343.jpg');
INSERT INTO `image` VALUES (150, 145, '0cfc58d4-4bf0-48bc-855a-79b45023eea9452.jpg');
INSERT INTO `image` VALUES (151, 146, '7563caea-91a7-4ff7-8498-0257494ab1c898.jpg');
INSERT INTO `image` VALUES (152, 147, 'f83c2e95-d221-4e0a-9845-3039357ccd6e87.jpg');
INSERT INTO `image` VALUES (153, 148, '6e8bcf50-954a-4f10-a313-358cd45b209112.jpg');
INSERT INTO `image` VALUES (154, 149, '3a9c1f75-54b2-42bc-9b5d-f2d70a7e63f935.jpg');
INSERT INTO `image` VALUES (155, 150, 'bff831b0-8b19-4eab-8630-7272dba756f0675.jpg');
INSERT INTO `image` VALUES (156, 151, 'c1263a47-a327-497f-b859-a91a9952237f5342.jpg');
INSERT INTO `image` VALUES (157, 152, 'fa9bd5d3-0682-4923-905b-8d354d560177765.jpg');
INSERT INTO `image` VALUES (158, 153, '3610a122-0f58-4253-a844-f28be4a413be633.jpg');
INSERT INTO `image` VALUES (159, 154, 'fe97509a-ffde-4a19-b380-815e372650a9yr.jpg');
INSERT INTO `image` VALUES (160, 155, '22b8b05a-28de-4f63-8810-7259f087c286rh0.jpg');
INSERT INTO `image` VALUES (161, 156, 'a13a5be7-b427-4e28-ab92-cfa88618e9856540.jpg');
INSERT INTO `image` VALUES (162, 157, '696a1580-77b6-4105-9250-2c6b56df02dcrfds.jpg');
INSERT INTO `image` VALUES (163, 158, 'fa0d7d8e-30a2-4cd2-99d5-7f0839a7981afewf.jpg');
INSERT INTO `image` VALUES (164, 159, '55299706-b7b3-4a25-8ede-2afcf0db2f96dssa.jpg');
INSERT INTO `image` VALUES (165, 160, '8182c412-7d7f-4a75-ad34-c50d14d3c2964645660.jpg');
INSERT INTO `image` VALUES (166, 161, '4bc07305-6171-4e93-ad57-e3529144166665460.jpg');
INSERT INTO `image` VALUES (167, 162, '75c1820d-c74d-4f99-b9f7-14489c053af2tg0.jpg');
INSERT INTO `image` VALUES (168, 163, '075d9536-444c-4ed7-a0f2-635c3abda677findfun.png');
INSERT INTO `image` VALUES (169, 164, 'fcfa6389-a22e-4626-a540-9611a5bedbf6findfun.png');
INSERT INTO `image` VALUES (170, 165, '0d5ef668-f8e8-4954-8fc3-2803e83827cdfindfun.png');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '系统信息主键',
  `sell_id` int(11) NULL DEFAULT NULL COMMENT '卖家id',
  `goods_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `buyer_id` int(11) NULL DEFAULT NULL COMMENT '买家id',
  `context` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '信息内容',
  `build_time` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息发送时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (18, 1, '吉他', 1, '124432', '2020-02-04 01:38:20');
INSERT INTO `notice` VALUES (19, 1, '吉他', 1, '我爱你卖家', '2020-02-04 01:38:01');
INSERT INTO `notice` VALUES (20, 1, 'sds', 2, 'csdsd', '2020-02-04 01:38:54');
INSERT INTO `notice` VALUES (21, 1, 'efdsf', 3, 'refsdf', '2020-02-04 01:38:22');
INSERT INTO `notice` VALUES (22, 1, 'fdss', 2, 'fsdfsdf', '2020-02-04 01:38:13');
INSERT INTO `notice` VALUES (23, 1, '测试发布', 2, '留言', '2020-04-11 11:35:39');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '订单表',
  `sellerId` int(10) NULL DEFAULT NULL COMMENT '卖家id',
  `buyerId` int(10) NULL DEFAULT NULL COMMENT '买家id',
  `goodsId` int(10) NULL DEFAULT NULL COMMENT '商品id',
  `comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '买家备注',
  `status` int(10) NULL DEFAULT 1 COMMENT '订单状态  默认1  失效0',
  `orderTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单创建时间或者提示信息 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (9, 1, 2, 85, '哈哈哈', 1, NULL);
INSERT INTO `order` VALUES (12, 1, 1, 157, '国足加油', 0, '2020-02-06');
INSERT INTO `order` VALUES (15, 1, 3, 160, '陈一发象棋', 0, '2020-02-06');
INSERT INTO `order` VALUES (16, 1, 1, 158, '新垣结衣订单羽毛', 0, '2020-02-06');
INSERT INTO `order` VALUES (17, 1, 3, 158, '陈一发羽毛', 1, NULL);
INSERT INTO `order` VALUES (18, 1, 1, 159, '新垣结衣 双排', 1, NULL);
INSERT INTO `order` VALUES (19, 1, 3, 159, '一发双排', 0, '2020-02-06');
INSERT INTO `order` VALUES (20, 1, 1, 161, '新垣结衣围棋', 1, NULL);
INSERT INTO `order` VALUES (21, 1, 3, 161, '发发围棋', 0, '2020-02-06');
INSERT INTO `order` VALUES (22, 1, 1, 137, 'fsdhfsjdl', 2, '该商品已售出');
INSERT INTO `order` VALUES (23, 1, 3, 138, 'gdfgd', 1, NULL);
INSERT INTO `order` VALUES (24, 1, 3, 139, 'gdfgd', 0, '2020-03-02');
INSERT INTO `order` VALUES (25, 1, 3, 141, 'dada', 1, NULL);
INSERT INTO `order` VALUES (26, 1, 3, 139, 'rwe', 0, '2020-03-02');
INSERT INTO `order` VALUES (27, 1, 3, 137, 'rwerw', 0, '2020-02-07');
INSERT INTO `order` VALUES (28, 1, 1, 144, '', 1, NULL);

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论回复主键',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户，外键',
  `atuser_id` int(11) NULL DEFAULT NULL,
  `commet_id` int(11) NULL DEFAULT NULL COMMENT '评论，外键',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回复内容',
  `create_at` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES (1, 1, 1, 1, '1', '1');

-- ----------------------------
-- Table structure for revert
-- ----------------------------
DROP TABLE IF EXISTS `revert`;
CREATE TABLE `revert`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '系统信息主键',
  `sell_id` int(11) NULL DEFAULT NULL COMMENT '卖家id',
  `goods_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `buyer_id` int(11) NULL DEFAULT NULL COMMENT '买家id',
  `context` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '信息内容',
  `build_time` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息发送时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of revert
-- ----------------------------
INSERT INTO `revert` VALUES (1, 1, NULL, 1, '啦啦啦', '2020-02-04 01:38:13');
INSERT INTO `revert` VALUES (2, 2, NULL, 3, '发地方大幅度', '2020-02-04 01:38:12');
INSERT INTO `revert` VALUES (3, 1, NULL, 1, '是该公司给', '2020-02-04 01:38:08');
INSERT INTO `revert` VALUES (4, 1, NULL, 1, '光伏发电', '2020-02-04 01:38:10');
INSERT INTO `revert` VALUES (18, 1, NULL, 2, 'csac', '2020-02-04 01:38:09');
INSERT INTO `revert` VALUES (19, 1, NULL, 2, '打发士大夫但是', '2020-02-04 01:38:14');
INSERT INTO `revert` VALUES (20, 1, NULL, 2, '出租车', '2020-02-04 01:38:07');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录使用的手机号',
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `QQ` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '即时通讯',
  `create_at` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '用户邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '15037752845', '古力娜扎', '2', '2222222222', '2020-01-15 08:31', '2250680284@qq.com');
INSERT INTO `user` VALUES (2, '15037752844', '迪丽热巴', '1', '2564645456', '2020-01-15 15:19', '2250680283@qq.com');
INSERT INTO `user` VALUES (3, '15037752843', '陈一发', '1', '2564645456', '2020-01-15 16:25', '2250680282@qq.com');
INSERT INTO `user` VALUES (34, '2', '陈一发', '1', '2564645456', '2020-01-15 16:25', '2250680282@qq.com');
INSERT INTO `user` VALUES (35, '15037752842', '马儿扎哈', '2', NULL, '2020-04-17 11:19', '2250680284@qq.com');

SET FOREIGN_KEY_CHECKS = 1;
