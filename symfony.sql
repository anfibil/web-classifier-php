-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 31, 2015 at 05:50 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `symfony`
--

-- --------------------------------------------------------

--
-- Table structure for table `ode_dataset`
--

CREATE TABLE IF NOT EXISTS `ode_dataset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `num_instances` int(11) NOT NULL,
  `num_features` int(11) NOT NULL,
  `filetype` longtext COLLATE utf8_unicode_ci NOT NULL,
  `filesize` bigint(20) NOT NULL,
  `filename` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ode_dataset`
--

INSERT INTO `ode_dataset` (`id`, `name`, `description`, `num_instances`, `num_features`, `filetype`, `filesize`, `filename`) VALUES
(1, 'Iris', '', 150, 4, 'CSV', 3867, 'iris'),
(2, 'Pima Indians Diabetes', '', 768, 8, 'CSV', 24576, 'pima-indians-diabetes'),
(3, 'Students', '', 1250, 25, 'CSV', 5661, 'students');

-- --------------------------------------------------------

--
-- Table structure for table `ode_models`
--

CREATE TABLE IF NOT EXISTS `ode_models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parameters` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:simple_array)',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `form` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ode_models`
--

INSERT INTO `ode_models` (`id`, `type`, `parameters`, `name`, `form`) VALUES
(1, 'classification', '("criterion","splitter","max_features_for_split","max_leaf_nodes","min_samples_split","min_samples_leaf","max_depth")', 'Decision Tree', '<div class="row">\n    <div class="col-lg-2">\n        <label>Criterion:</label>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="gini" name="criterion" checked="" class="required"> Gini</label>\n        </div>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="entropy" name="criterion" class="required"> Entropy</label>\n        </div>\n    </div>\n    <div class="col-lg-2">\n        <label>Splitter:</label>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="best" name="splitter" checked="" class="required"> Best</label>\n        </div>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="random" name="splitter" class="required"> Random</label>\n        </div>\n    </div>\n    <div class="col-lg-4 text-center">\n        <label>Grow a tree with<i>max_leaf_nodes</i>in best-first fashion:&nbsp&nbsp<i>max_leaf_nodes</i>=<span class="example-val" style="color:#1AB394" id="max_leaf_nodes-value"></span></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="max_leaf_nodes-slider"></div>\n            <input type="hidden" name="max_leaf_nodes" id="max_leaf_nodes" value="">\n            <br/>\n        </div>\n    </div>\n    <div class="col-lg-4 text-center">\n        <label>Minimum number of samples required to be at a leaf node:&nbsp&nbsp<i>min_samples_leaf</i>=<span class="example-val" style="color:#1AB394" id="min_samples_leaf-value"></span></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="min_samples_leaf-slider"></div>\n            <input type="hidden" name="min_samples_leaf" id="min_samples_leaf" value="">\n        </div>\n    </div>\n</div>\n<div class="hr-line-dashed"></div>\n<div class="row">\n    <div class="col-lg-4 text-center">\n        <label>Number of features to consider when looking for the best split:&nbsp&nbsp<i>max_features_for_split</i>=<span class="example-val" style="color:#1AB394" id="max_features_for_split-value"></span></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="max_features_for_split-slider"></div>\n            <input type="hidden" name="max_features_for_split" id="max_features_for_split" value="">\n            <br/>\n        </div>\n    </div>\n    <div class="col-lg-4 text-center">\n        <label>Minimum number of samples required to split an internal node:&nbsp&nbsp<i>min_samples_split</i>=<span class="example-val" style="color:#1AB394" id="min_samples_split-value"></span></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="min_samples_split-slider"></div>\n            <input type="hidden" name="min_samples_split" id="min_samples_split" value="">\n        </div>\n    </div>\n    <div class="col-lg-4 text-center" style="display:inline-block; vertical-align: middle; float: none; margin-right:-4px;">\n        <label>Maximum depth of the tree:&nbsp&nbsp<i>max_depth</i>=<span class="example-val" style="color:#1AB394" id="max_depth-value"></span></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="max_depth-slider"></div>\n            <input type="hidden" name="max_depth" id="max_depth" value="">\n        </div>\n    </div>\n</div>\n<div class="hr-line-dashed"></div>\n<script>\n    $(document).ready(function() {\n        $(''.i-checks'').iCheck({\n            checkboxClass: ''icheckbox_square-green'',\n            radioClass: ''iradio_square-green'',\n        });\n        $(''#max_features_for_split-slider'').noUiSlider({\n            start: [3],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [20]\n            }\n        });\n        $(''#max_features_for_split-slider'').Link(''lower'').to($(''#max_features_for_split-value''));\n        $(''#max_features_for_split-slider'').Link(''lower'').to($(''#max_features_for_split''));\n        $(''#min_samples_split-slider'').noUiSlider({\n            start: [3],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [20]\n            }\n        });\n        $(''#min_samples_split-slider'').Link(''lower'').to($(''#min_samples_split-value''));\n        $(''#min_samples_split-slider'').Link(''lower'').to($(''#min_samples_split''));\n        $(''#max_leaf_nodes-slider'').noUiSlider({\n            start: [3],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [20]\n            }\n        });\n        $(''#max_leaf_nodes-slider'').Link(''lower'').to($(''#max_leaf_nodes-value''));\n        $(''#max_leaf_nodes-slider'').Link(''lower'').to($(''#max_leaf_nodes''));\n        $(''#min_samples_leaf-slider'').noUiSlider({\n            start: [3],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [20]\n            }\n        });\n        $(''#min_samples_leaf-slider'').Link(''lower'').to($(''#min_samples_leaf-value''));\n        $(''#min_samples_leaf-slider'').Link(''lower'').to($(''#min_samples_leaf''));\n        $(''#max_depth-slider'').noUiSlider({\n            start: [3],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [20]\n            }\n        });\n        $(''#max_depth-slider'').Link(''lower'').to($(''#max_depth-value''));\n        $(''#max_depth-slider'').Link(''lower'').to($(''#max_depth''))\n    });\n</script>'),
(2, 'classification', '("alpha", "fit_prior", "class_prior")', 'Naive Bayes', '<h1>NAIVE BAYES FORM</h1>');

-- --------------------------------------------------------

--
-- Table structure for table `ode_results`
--

CREATE TABLE IF NOT EXISTS `ode_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `algorithm` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `params` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `runtime` int(11) DEFAULT NULL,
  `finished` tinyint(1) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dataset` int(11) NOT NULL,
  `result` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

--
-- Dumping data for table `ode_results`
--

INSERT INTO `ode_results` (`id`, `algorithm`, `params`, `runtime`, `finished`, `username`, `dataset`, `result`) VALUES
(1, '2', NULL, NULL, 1, 'user', 2, '{"rmse": 0.6131991154781301, "recall": 0.27320791319153814, "precision": 0.9319086369609, "fmeasure": 0.9260352345655795, "auroc": 0.702416452213628, "accuracy": 0.9175255827353092}'),
(2, '1', NULL, NULL, 1, 'user', 2, '{"rmse": 0.6540246557225885, "recall": 0.6977473431617964, "precision": 0.09354873755114368, "fmeasure": 0.7314625139188926, "auroc": 0.970104126933255, "accuracy": 0.37629815418212686}'),
(3, '1', NULL, NULL, 1, 'user', 2, '{"rmse": 0.7511585415618841, "recall": 0.3586166738245544, "precision": 0.7002514150863919, "fmeasure": 0.5963922213948614, "auroc": 0.2385669159198056, "accuracy": 0.33078877585975286}'),
(4, '1', NULL, NULL, 1, 'user', 1, '{"rmse": 0.9029395409050894, "recall": 0.8092252051633034, "precision": 0.5450099110557933, "fmeasure": 0.48931977169138696, "auroc": 0.01941498560386057, "accuracy": 0.004371978256039966}'),
(5, '1', NULL, NULL, 1, 'user', 1, '{"rmse": 0.5536622653968705, "recall": 0.6573380003023789, "precision": 0.2909953562133658, "fmeasure": 0.8142099563269646, "auroc": 0.956646450209591, "accuracy": 0.7787731576213791}'),
(6, '1', NULL, NULL, 1, 'user', 1, '{"rmse": 0.15880572813455707, "recall": 0.40191958089934865, "precision": 0.7614343868952277, "fmeasure": 0.068764837843168, "auroc": 0.039619633744761074, "accuracy": 0.7437066885888937}'),
(7, '1', NULL, NULL, 1, 'user', 1, '{"rmse": 0.07306462321027551, "recall": 0.7731799486669746, "precision": 0.41749378529915926, "fmeasure": 0.08304352499269141, "auroc": 0.45740846888440556, "accuracy": 0.7197396848443549}'),
(8, '1', NULL, NULL, 1, 'user', 1, '{"rmse": 0.2934941182608706, "recall": 0.7525660799317341, "precision": 0.117725948750946, "fmeasure": 0.8884315414384928, "auroc": 0.5004969983747972, "accuracy": 0.37586680903915337}'),
(9, '1', NULL, NULL, 1, 'user', 1, '{"rmse": 0.2131036149186042, "recall": 0.6131603745499833, "precision": 0.1509071420367416, "fmeasure": 0.6199691894670196, "auroc": 0.15429938799513132, "accuracy": 0.14887753180401386}'),
(10, '1', NULL, NULL, 1, 'user', 1, '{"rmse": 0.8876748815966766, "recall": 0.3682145820955438, "precision": 0.796769322840799, "fmeasure": 0.6306169583173501, "auroc": 0.45687418821675785, "accuracy": 0.55366074011863}'),
(11, '1', NULL, NULL, 1, 'user', 1, '{"rmse": 0.9388913542936957, "recall": 0.8505826084220018, "precision": 0.16230434368099744, "fmeasure": 0.12264823047830253, "auroc": 0.21722869556416424, "accuracy": 0.40590392376977624}'),
(12, '1', NULL, NULL, 1, 'user', 3, '{"rmse": 0.689587411125717, "recall": 0.10194026527517319, "precision": 0.13003834750254772, "fmeasure": 0.04088974414282476, "auroc": 0.1839725610407389, "accuracy": 0.330337187102015}'),
(13, '1', NULL, NULL, 1, 'user', 1, '{"rmse": 0.6003134451991737, "recall": 0.711062416983231, "precision": 0.4453610598218374, "fmeasure": 0.46450020733180497, "auroc": 0.14096241376226493, "accuracy": 0.8627407186546454}');

-- --------------------------------------------------------

--
-- Table structure for table `ode_users`
--

CREATE TABLE IF NOT EXISTS `ode_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email_canonical` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `locked` tinyint(1) NOT NULL,
  `expired` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `credentials_expired` tinyint(1) NOT NULL,
  `credentials_expire_at` datetime DEFAULT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `affiliation` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastEdited` datetime NOT NULL,
  `profilePicturePath` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C7857F0E92FC23A8` (`username_canonical`),
  UNIQUE KEY `UNIQ_C7857F0EA0D96FBF` (`email_canonical`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ode_users`
--

INSERT INTO `ode_users` (`id`, `username`, `username_canonical`, `email`, `email_canonical`, `enabled`, `salt`, `password`, `last_login`, `locked`, `expired`, `expires_at`, `confirmation_token`, `password_requested_at`, `roles`, `credentials_expired`, `credentials_expire_at`, `firstname`, `lastname`, `affiliation`, `lastEdited`, `profilePicturePath`) VALUES
(2, 'user', 'user', 'user@email.com', 'user@email.com', 1, 'av2sn0ujazkgcok4s004og8o40gss8w', '170IfD1qEs26TVFKqwr3G0tGJxBZgopmNHdMaOkHuy0k8J5E/rffVtWBGQvVH5/g/Gg2mgxpR5lqGRmaMSPitg==', '2015-03-30 20:41:20', 0, 0, NULL, NULL, NULL, 'a:0:{}', 0, NULL, 'FirstName', 'LastName', 'University of Notre Dame', '2015-03-30 20:41:21', '/assets/profilepictures/ee11cbb19052e40b07aac0ca060c23ee');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
