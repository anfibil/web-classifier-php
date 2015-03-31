-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 01, 2015 at 12:05 AM
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
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ode_models`
--

INSERT INTO `ode_models` (`id`, `type`, `parameters`, `name`, `form`, `description`) VALUES
(1, 'classification', '("criterion","splitter","max_features_for_split","max_leaf_nodes","min_samples_split","min_samples_leaf","max_depth")', 'Decision Tree', '<div class="row">\n    <div class="col-lg-2">\n        <label>Criterion:</label>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="gini" name="criterion" checked="" class="required"> Gini</label>\n        </div>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="entropy" name="criterion" class="required"> Entropy</label>\n        </div>\n    </div>\n    <div class="col-lg-2">\n        <label>Splitter:</label>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="best" name="splitter" checked="" class="required"> Best</label>\n        </div>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="random" name="splitter" class="required"> Random</label>\n        </div>\n    </div>\n    <div class="col-lg-4 text-center">\n        <label>max_leaf_nodes = <span class="example-val" style="color:#1AB394" id="max_leaf_nodes-value"></span>  <i class="fa fa-question-circle" style="color:#676a6c" id="q1"></i></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="max_leaf_nodes-slider"></div>\n            <input type="hidden" name="max_leaf_nodes" id="max_leaf_nodes" value="">\n            <br/>\n        </div>\n    </div>\n    <div class="col-lg-4 text-center">\n        <label>min_samples_leaf = <span class="example-val" style="color:#1AB394" id="min_samples_leaf-value"></span>  <i class="fa fa-question-circle" style="color:#676a6c" id="q2"></i></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="min_samples_leaf-slider"></div>\n            <input type="hidden" name="min_samples_leaf" id="min_samples_leaf" value="">\n        </div>\n    </div>\n</div>\n<div class="hr-line-dashed"></div>\n<div class="row">\n    <div class="col-lg-4 text-center">\n        <label>max_features = <span class="example-val" style="color:#1AB394" id="max_features-value"></span>  <i class="fa fa-question-circle" style="color:#676a6c" id="q3"></i></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="max_features-slider"></div>\n            <input type="hidden" name="max_features" id="max_features" value="">\n            <br/>\n        </div>\n    </div>\n    <div class="col-lg-4 text-center">\n        <label>min_samples_split = <span class="example-val" style="color:#1AB394" id="min_samples_split-value"></span>  <i class="fa fa-question-circle" style="color:#676a6c" id="q4"></i></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="min_samples_split-slider"></div>\n            <input type="hidden" name="min_samples_split" id="min_samples_split" value="">\n        </div>\n    </div>\n    <div class="col-lg-4 text-center" style="display:inline-block; vertical-align: middle; float: none; margin-right:-4px;">\n        <label>max_depth = <span class="example-val" style="color:#1AB394" id="max_depth-value"></span>  <i class="fa fa-question-circle" style="color:#676a6c" id="q5"></i></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="max_depth-slider"></div>\n            <input type="hidden" name="max_depth" id="max_depth" value="">\n        </div>\n    </div>\n</div>\n<div class="hr-line-dashed"></div>\n<script>\n    $(document).ready(function() {\n        $(''.i-checks'').iCheck({\n            checkboxClass: ''icheckbox_square-green'',\n            radioClass: ''iradio_square-green'',\n        });\n        $(''#max_features-slider'').noUiSlider({\n            start: [0],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [0],\n                ''max'': [NUM_FEATURES]\n            }\n        });\n        $(''#max_features-slider'').Link(''lower'').to($(''#max_features-value''));\n        $(''#max_features-slider'').Link(''lower'').to($(''#max_features''));\n        $(''#min_samples_split-slider'').noUiSlider({\n            start: [0],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [0],\n                ''max'': [NUM_INSTANCES]\n            }\n        });\n        $(''#min_samples_split-slider'').Link(''lower'').to($(''#min_samples_split-value''));\n        $(''#min_samples_split-slider'').Link(''lower'').to($(''#min_samples_split''));\n        $(''#max_leaf_nodes-slider'').noUiSlider({\n            start: [0],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [0],\n                ''max'': [20]\n            }\n        });\n        $(''#max_leaf_nodes-slider'').Link(''lower'').to($(''#max_leaf_nodes-value''));\n        $(''#max_leaf_nodes-slider'').Link(''lower'').to($(''#max_leaf_nodes''));\n        $(''#min_samples_leaf-slider'').noUiSlider({\n            start: [0],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [0],\n                ''max'': [NUM_FEATURES]\n            }\n        });\n        $(''#min_samples_leaf-slider'').Link(''lower'').to($(''#min_samples_leaf-value''));\n        $(''#min_samples_leaf-slider'').Link(''lower'').to($(''#min_samples_leaf''));\n        $(''#max_depth-slider'').noUiSlider({\n            start: [0],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [0],\n                ''max'': [20]\n            }\n        });\n        $(''#max_depth-slider'').Link(''lower'').to($(''#max_depth-value''));\n        $(''#max_depth-slider'').Link(''lower'').to($(''#max_depth''));\n\n        $("#q1").qtip({ \n                content: {\n                    text: ''Grow a tree with <i>max_leaf_nodes</i> in best-first fashion. Best nodes are defined as relative reduction in impurity. If <strong>0</strong> then unlimited number of leaf nodes. If not <strong>0</strong> then <i>max_depth</i> will be ignored.'',\n                    title:''<i>max_leaf_nodes</i>''\n                },\n                style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q2").qtip({ \n                content: {\n                    text: ''The minimum number of samples required to be at a leaf node.'',\n                    title:''<i>min_samples_leaf</i>''\n                },\n                style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q3").qtip({ \n                content: {\n                    text: ''The number of features to consider when looking for the best split.'',\n                    title:''<i>max_features</i>''\n                },\n                style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q4").qtip({ \n                content: {\n                    text: ''The minimum number of samples required to split an internal node.'',\n                    title:''<i>min_samples_split</i>''\n                },\n                style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q5").qtip({ \n                content: {\n                    text: ''The maximum depth of the tree. If <strong>0</strong>, then nodes are expanded until all leaves are pure or until all leaves contain less than <i>min_samples_split</i> samples. Ignored if <i>max_leaf_nodes</i> is not <strong>0</strong>.'',\n                    title:''<i>max_depth</i>''\n                },\n                style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        })\n    });\n</script>', '<h4 class="m-b-xxs text-center">Decision Tree Classifier <i class="fa fa-tree"></i></h4><p>A decision tree is a decision support tool that uses a tree-like graph ormodel of decisions and their possible consequences, including chance eventoutcomes, resource costs, and utility. It is one way to display an algorithm.<a href="http://en.wikipedia.org/wiki/Decision_tree_learning" target="_blank"> [ref]</a></p><div class="col-xs-6"> <div> <span>Complexity</span> <small class="pull-right">5/10</small> </div> <div class="progress progress-small"> <div class="progress-bar progress-bar-warning" style="width: 50%;"> </div> </div></div><div class="col-xs-6"> <div> <span>Interpretability</span> <small class="pull-right">9/10</small> </div> <div class="progress progress-small"> <div class="progress-bar" style="width: 90%;"> </div> </div></div>'),
(2, 'classification', '("alpha", "fit_prior", "class_prior")', 'Gaussian Naive Bayes', '<h4><b>There are no configurable parameters for the selected model.</b></h4>', '<h4 class="m-b-xxs text-center">Naive Bayes Classifier <i class="fa fa-bars"></i></h4><p>Naive Bayes methods are a set of supervised learning algorithms based on applying Bayes’ theorem with the “naive” assumption of independence between every pair of features.<a href="http://en.wikipedia.org/wiki/Naive_Bayes_classifier" target="_blank"> [ref]</a></p><div class="col-xs-6"> <div> <span>Complexity</span> <small class="pull-right">3/10</small> </div> <div class="progress progress-small"> <div class="progress-bar" style="width: 30%;"> </div> </div></div><div class="col-xs-6"> <div> <span>Interpretability</span> <small class="pull-right">5/10</small> </div> <div class="progress progress-small"> <div class="progress-bar progress-bar-warning" style="width: 50%;"> </div> </div></div>'),
(3, 'classification', '("penalty","alpha","fit_intercept","n_iter","shuffle","eta0","warm_start")', 'Perceptron', '', '');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `ode_results`
--

INSERT INTO `ode_results` (`id`, `algorithm`, `params`, `runtime`, `finished`, `username`, `dataset`, `result`) VALUES
(1, '2', NULL, NULL, 1, 'user', 2, '{"rmse": 0.6131991154781301, "recall": 0.27320791319153814, "precision": 0.9319086369609, "fmeasure": 0.9260352345655795, "auroc": 0.702416452213628, "accuracy": 0.9175255827353092}'),
(2, '1', NULL, NULL, 1, 'user', 2, '{"rmse": 0.6540246557225885, "recall": 0.6977473431617964, "precision": 0.09354873755114368, "fmeasure": 0.7314625139188926, "auroc": 0.970104126933255, "accuracy": 0.37629815418212686}'),
(3, '1', NULL, NULL, 1, 'user', 2, '{"rmse": 0.7511585415618841, "recall": 0.3586166738245544, "precision": 0.7002514150863919, "fmeasure": 0.5963922213948614, "auroc": 0.2385669159198056, "accuracy": 0.33078877585975286}'),
(4, '1', NULL, NULL, 1, 'user', 1, '{"rmse": 0.9029395409050894, "recall": 0.8092252051633034, "precision": 0.5450099110557933, "fmeasure": 0.48931977169138696, "auroc": 0.01941498560386057, "accuracy": 0.004371978256039966}'),
(5, '1', NULL, NULL, 1, 'user', 1, '{"rmse": 0.2135304553229933, "recall": 0.2566484167431351, "precision": 0.8486203322385182, "fmeasure": 0.2909731980800867, "auroc": 0.39258773986372, "accuracy": 0.6537807623105396}'),
(6, '1', NULL, NULL, 1, 'user', 2, '{"rmse": 0.13215872490041203, "recall": 0.4044765005734927, "precision": 0.6452019095301713, "fmeasure": 0.768109659295728, "auroc": 0.0787558713614831, "accuracy": 0.35312325201097694}'),
(7, '1', NULL, NULL, 1, 'user', 1, '{"rmse": 0.8290521671133537, "recall": 0.24500942060728115, "precision": 0.11342963556064167, "fmeasure": 0.4461786114183597, "auroc": 0.19643853461880134, "accuracy": 0.8500187393517662}'),
(8, '1', NULL, NULL, 1, 'user', 2, '{"rmse": 0.06691999414173122, "recall": 0.3343010008822317, "precision": 0.24286623200632285, "fmeasure": 0.025089891437816036, "auroc": 0.5590163259010023, "accuracy": 0.009971779110728107}');

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
(2, 'user', 'user', 'user@email.com', 'user@email.com', 1, 'av2sn0ujazkgcok4s004og8o40gss8w', '170IfD1qEs26TVFKqwr3G0tGJxBZgopmNHdMaOkHuy0k8J5E/rffVtWBGQvVH5/g/Gg2mgxpR5lqGRmaMSPitg==', '2015-03-31 17:23:38', 0, 0, NULL, NULL, NULL, 'a:0:{}', 0, NULL, 'FirstName', 'LastName', 'University of Notre Dame', '2015-03-31 17:23:38', '/assets/profilepictures/ee11cbb19052e40b07aac0ca060c23ee');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
