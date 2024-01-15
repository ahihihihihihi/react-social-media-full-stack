/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `Comments`;
CREATE TABLE `Comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `postId` int(11) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `postId` (`postId`),
  CONSTRAINT `Comments_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Comments_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `Posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Likes`;
CREATE TABLE `Likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `postId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `postId` (`postId`),
  CONSTRAINT `Likes_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Likes_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `Posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Posts`;
CREATE TABLE `Posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `Posts_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Relationships`;
CREATE TABLE `Relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `followerUserId` int(11) NOT NULL,
  `followedUserId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `followerUserId` (`followerUserId`),
  KEY `followedUserId` (`followedUserId`),
  CONSTRAINT `Relationships_ibfk_1` FOREIGN KEY (`followerUserId`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Relationships_ibfk_2` FOREIGN KEY (`followedUserId`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Stories`;
CREATE TABLE `Stories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(200) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `Stories_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(200) NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 NOT NULL,
  `coverPic` varchar(300) DEFAULT NULL,
  `profilePic` varchar(300) DEFAULT NULL,
  `city` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `website` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;





INSERT INTO `Posts` (`id`, `desc`, `img`, `userId`, `createdAt`) VALUES
(1, 'desc1', NULL, 1, '2024-01-15 09:24:56');
INSERT INTO `Posts` (`id`, `desc`, `img`, `userId`, `createdAt`) VALUES
(2, 'desc2', NULL, 2, NULL);
INSERT INTO `Posts` (`id`, `desc`, `img`, `userId`, `createdAt`) VALUES
(3, 'desc4', NULL, 4, NULL);





INSERT INTO `Users` (`id`, `username`, `email`, `password`, `name`, `coverPic`, `profilePic`, `city`, `website`) VALUES
(1, 'test', 'test@gmail.com', '$2a$10$9F0I1bw0fBIUFdQ5BcIVrOIWP6nLdDy7uBButU5mBnUfRltbuvhue', 'John Doe', NULL, NULL, NULL, NULL);
INSERT INTO `Users` (`id`, `username`, `email`, `password`, `name`, `coverPic`, `profilePic`, `city`, `website`) VALUES
(2, 'test2', 'test2@email.com', '$2a$10$ZhkG2nxIY6vL2O1y5M0d1eovV7nrfMKCRR0lbG7QVWFJJ4eoavhdy', 'Test2', 'https://images.pexels.com/photos/13916254/pexels-photo-13916254.jpeg?auto=compress&cs=tinysrgb&w=1600&lazy=load', 'https://images.pexels.com/photos/4881619/pexels-photo-4881619.jpeg?auto=compress&cs=tinysrgb&w=1600', 'SG', 'http://ahihi.com');
INSERT INTO `Users` (`id`, `username`, `email`, `password`, `name`, `coverPic`, `profilePic`, `city`, `website`) VALUES
(4, 'test3', 'test3@gmail.com', '$2a$10$6cJUyHVDJikrI2O6pLuy9OOTOPEFyJOLEk44JZMBQ.GB/72/TVmyq', 'John Doe', NULL, NULL, NULL, NULL);


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;