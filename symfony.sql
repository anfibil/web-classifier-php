-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 10, 2015 at 09:53 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `ode_dataset`
--

INSERT INTO `ode_dataset` (`id`, `name`, `description`, `num_instances`, `num_features`, `filetype`, `filesize`, `filename`) VALUES
(1, 'Iris', '', 150, 4, 'CSV', 3867, 'iris'),
(2, 'Pima Indians Diabetes', '', 768, 8, 'CSV', 24576, 'pima-indians-diabetes'),
(3, 'Seismic Bumps', '', 2584, 12, 'CSV', 84020, 'seismic-bumps'),
(4, 'Adult Salary', '', 48842, 14, 'CSV', 3844216, 'salary');

-- --------------------------------------------------------

--
-- Table structure for table `ode_models`
--

CREATE TABLE IF NOT EXISTS `ode_models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parameters` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `form` longtext COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `ode_models`
--

INSERT INTO `ode_models` (`id`, `type`, `parameters`, `name`, `form`, `description`) VALUES
(1, 'classification', '{"criterion":"string","splitter":"string","max_features":"int","max_leaf_nodes":"int","min_samples_split":"int","min_samples_leaf":"int","max_depth":"int"}', 'Decision Tree', '<div class="row">\n    <div class="col-lg-2">\n        <label>Criterion:</label>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="gini" name="criterion" checked="" class="required"> Gini</label>\n        </div>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="entropy" name="criterion" class="required"> Entropy</label>\n        </div>\n    </div>\n    <div class="col-lg-2">\n        <label>Splitter:</label>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="best" name="splitter" checked="" class="required"> Best</label>\n        </div>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="random" name="splitter" class="required"> Random</label>\n        </div>\n    </div>\n    <div class="col-lg-4 text-center">\n        <label>max_leaf_nodes = <span class="example-val" style="color:#1AB394" id="max_leaf_nodes-value"></span>  <i class="fa fa-question-circle" style="color:#676a6c" id="q1"></i></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="max_leaf_nodes-slider"></div>\n            <input type="hidden" name="max_leaf_nodes" id="max_leaf_nodes" value="">\n            <br/>\n        </div>\n    </div>\n    <div class="col-lg-4 text-center">\n        <label>min_samples_leaf = <span class="example-val" style="color:#1AB394" id="min_samples_leaf-value"></span>  <i class="fa fa-question-circle" style="color:#676a6c" id="q2"></i></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="min_samples_leaf-slider"></div>\n            <input type="hidden" name="min_samples_leaf" id="min_samples_leaf" value="">\n        </div>\n    </div>\n</div>\n<div class="hr-line-dashed"></div>\n<div class="row">\n    <div class="col-lg-4 text-center">\n        <label>max_features = <span class="example-val" style="color:#1AB394" id="max_features-value"></span>  <i class="fa fa-question-circle" style="color:#676a6c" id="q3"></i></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="max_features-slider"></div>\n            <input type="hidden" name="max_features" id="max_features" value="">\n            <br/>\n        </div>\n    </div>\n    <div class="col-lg-4 text-center">\n        <label>min_samples_split = <span class="example-val" style="color:#1AB394" id="min_samples_split-value"></span>  <i class="fa fa-question-circle" style="color:#676a6c" id="q4"></i></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="min_samples_split-slider"></div>\n            <input type="hidden" name="min_samples_split" id="min_samples_split" value="">\n        </div>\n    </div>\n    <div class="col-lg-4 text-center" style="display:inline-block; vertical-align: middle; float: none; margin-right:-4px;">\n        <label>max_depth = <span class="example-val" style="color:#1AB394" id="max_depth-value"></span>  <i class="fa fa-question-circle" style="color:#676a6c" id="q5"></i></label>\n        <div class="col-lg-10 col-lg-offset-1">\n            <div id="max_depth-slider"></div>\n            <input type="hidden" name="max_depth" id="max_depth" value="">\n        </div>\n    </div>\n</div>\n<div class="hr-line-dashed"></div>\n<script>\n    $(document).ready(function() {\n        $(''.i-checks'').iCheck({\n            checkboxClass: ''icheckbox_square-green'',\n            radioClass: ''iradio_square-green'',\n        });\n        $(''#max_features-slider'').noUiSlider({\n            start: [1],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [NUM_FEATURES]\n            }\n        });\n        $(''#max_features-slider'').Link(''lower'').to($(''#max_features-value''));\n        $(''#max_features-slider'').Link(''lower'').to($(''#max_features''));\n        $(''#min_samples_split-slider'').noUiSlider({\n            start: [1],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [NUM_INSTANCES]\n            }\n        });\n        $(''#min_samples_split-slider'').Link(''lower'').to($(''#min_samples_split-value''));\n        $(''#min_samples_split-slider'').Link(''lower'').to($(''#min_samples_split''));\n        $(''#max_leaf_nodes-slider'').noUiSlider({\n            start: [2],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [2],\n                ''max'': [20]\n            }\n        });\n        $(''#max_leaf_nodes-slider'').Link(''lower'').to($(''#max_leaf_nodes-value''));\n        $(''#max_leaf_nodes-slider'').Link(''lower'').to($(''#max_leaf_nodes''));\n        $(''#min_samples_leaf-slider'').noUiSlider({\n            start: [1],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [NUM_FEATURES]\n            }\n        });\n        $(''#min_samples_leaf-slider'').Link(''lower'').to($(''#min_samples_leaf-value''));\n        $(''#min_samples_leaf-slider'').Link(''lower'').to($(''#min_samples_leaf''));\n        $(''#max_depth-slider'').noUiSlider({\n            start: [1],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [20]\n            }\n        });\n        $(''#max_depth-slider'').Link(''lower'').to($(''#max_depth-value''));\n        $(''#max_depth-slider'').Link(''lower'').to($(''#max_depth''));\n\n        $("#q1").qtip({ \n                content: {\n                    text: ''Grow a tree with <i>max_leaf_nodes</i> in best-first fashion. Best nodes are defined as relative reduction in impurity. If <strong>0</strong> then unlimited number of leaf nodes. If not <strong>0</strong> then <i>max_depth</i> will be ignored.'',\n                    title:''<i>max_leaf_nodes</i>''\n                },\n                style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q2").qtip({ \n                content: {\n                    text: ''The minimum number of samples required to be at a leaf node.'',\n                    title:''<i>min_samples_leaf</i>''\n                },\n                style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q3").qtip({ \n                content: {\n                    text: ''The number of features to consider when looking for the best split.'',\n                    title:''<i>max_features</i>''\n                },\n                style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q4").qtip({ \n                content: {\n                    text: ''The minimum number of samples required to split an internal node.'',\n                    title:''<i>min_samples_split</i>''\n                },\n                style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q5").qtip({ \n                content: {\n                    text: ''The maximum depth of the tree. If <strong>0</strong>, then nodes are expanded until all leaves are pure or until all leaves contain less than <i>min_samples_split</i> samples. Ignored if <i>max_leaf_nodes</i> is not <strong>0</strong>.'',\n                    title:''<i>max_depth</i>''\n                },\n                style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        })\n    });\n</script>', '<h4 class="m-b-xxs text-center">Decision Tree Classifier <i class="fa fa-tree"></i></h4><p>A decision tree is a decision support tool that uses a tree-like graph ormodel of decisions and their possible consequences, including chance eventoutcomes, resource costs, and utility. It is one way to display an algorithm.<a href="http://en.wikipedia.org/wiki/Decision_tree_learning" target="_blank"> [ref]</a></p><div class="col-xs-6"> <div> <span>Complexity</span> <small class="pull-right">5/10</small> </div> <div class="progress progress-small"> <div class="progress-bar progress-bar-warning" style="width: 50%;"> </div> </div></div><div class="col-xs-6"> <div> <span>Interpretability</span> <small class="pull-right">9/10</small> </div> <div class="progress progress-small"> <div class="progress-bar" style="width: 90%;"> </div> </div></div>'),
(2, 'classification', '("alpha", "fit_prior", "class_prior")', 'Gaussian Naive Bayes', '<h4><b>There are no configurable parameters for the selected model.</b></h4>', '<h4 class="m-b-xxs text-center">Naive Bayes Classifier <i class="fa fa-bars"></i></h4><p>Naive Bayes methods are a set of supervised learning algorithms based on applying Bayes’ theorem with the “naive” assumption of independence between every pair of features.<a href="http://en.wikipedia.org/wiki/Naive_Bayes_classifier" target="_blank"> [ref]</a></p><div class="col-xs-6"> <div> <span>Complexity</span> <small class="pull-right">3/10</small> </div> <div class="progress progress-small"> <div class="progress-bar" style="width: 30%;"> </div> </div></div><div class="col-xs-6"> <div> <span>Interpretability</span> <small class="pull-right">5/10</small> </div> <div class="progress progress-small"> <div class="progress-bar progress-bar-warning" style="width: 50%;"> </div> </div></div>'),
(3, 'classification', '{"penalty":"string","fit_intercept":"bool","n_iter":"int","shuffle":"bool","eta0":"float","warm_start":"bool"}', 'Perceptron', '<div class="row">\n    <div class="col-lg-2">\n        <label>Penalty: <i class="fa fa-question-circle" style="color:#676a6c" id="q1"></i></label>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="none" name="penalty" checked=""  class="required"> None</label>\n        </div>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="l1" name="penalty" class="required"> L1 </label>\n        </div>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="l2" name="penalty" class="required"> L2</label>\n        </div>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="elasticnet" name="penalty" class="required"> Elasticnet</label>\n        </div>\n    </div>\n    <div class="col-lg-2">\n        <label>fit_intercept: <i class="fa fa-question-circle" style="color:#676a6c" id="q2"></i></label>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="1" name="fit_intercept" checked="" class="required"> True</label>\n        </div>\n        <div class="radio i-checks">\n            <label>\n                <input type="radio" value="0" name="fit_intercept" class="required"> False</label>\n        </div>\n    </div>\n    <div class="col-lg-4 text-center">\n        <div class="row text-center">\n            <label>n_iter = <span class="example-val" style="color:#1AB394" id="n_iter-value"></span>  <i class="fa fa-question-circle" style="color:#676a6c" id="q3"></i></label>\n            <div class="col-lg-10 col-lg-offset-1">\n                <div id="n_iter-slider"></div>\n                <input type="hidden" name="n_iter" id="n_iter" value="">\n            </div>\n        </div>\n\n        <br/>\n        <label>shuffle: <i class="fa fa-question-circle" style="color:#676a6c" id="q4"></i></label>\n        <div class="row">\n            <div class="radio i-checks">\n                <label>\n                    <input type="radio" value="1" name="shuffle" checked="" class="required"> True</label>\n            </div>\n            <div class="radio i-checks">\n                <label>\n                    <input type="radio" value="0" name="shuffle" class="required"> False</label>\n            </div>\n        </div>\n    </div>\n    <div class="col-lg-4 text-center">\n        <div class="row text-center">\n            <label>eta0 = <span class="example-val" style="color:#1AB394" id="eta0-value"></span>  <i class="fa fa-question-circle" style="color:#676a6c" id="q5"></i></label>\n            <div class="col-lg-10 col-lg-offset-1">\n                <div id="eta0-slider"></div>\n                <input type="hidden" name="eta0" id="eta0" value="">\n            </div>\n        </div>\n        <br/>\n        <label>warm_start : <i class="fa fa-question-circle" style="color:#676a6c" id="q6"></i></label>\n        <div class="row">\n            <div class="radio i-checks">\n                <label>\n                    <input type="radio" value="1" name="warm_start" checked="" class="required"> True</label>\n            </div>\n            <div class="radio i-checks">\n                <label>\n                    <input type="radio" value="0" name="warm_start" class="required"> False</label>\n            </div>\n        </div>\n    </div>\n</div>\n<script>\n    $(document).ready(function() {\n        $(''.i-checks'').iCheck({\n            checkboxClass: ''icheckbox_square-green'',\n            radioClass: ''iradio_square-green'',\n        });\n\n        $(''#n_iter-slider'').noUiSlider({\n            start: [5],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [20]\n            }\n        });\n        $(''#n_iter-slider'').Link(''lower'').to($(''#n_iter-value''));\n        $(''#n_iter-slider'').Link(''lower'').to($(''#n_iter''));\n\n        $(''#eta0-slider'').noUiSlider({\n            start: [1],\n            step: 0.1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [10]\n            }\n        });\n        $(''#eta0-slider'').Link(''lower'').to($(''#eta0-value''));\n        $(''#eta0-slider'').Link(''lower'').to($(''#eta0''));\n\n\n        $("#q1").qtip({\n            content: {\n                text: ''The penalty (aka regularization term) to be used.'',\n                title:''<i>penalty</i>''\n            },\n            style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q2").qtip({\n            content: {\n                text: ''Whether the intercept should be estimated or not. If False, the data is assumed to be already centered.'',\n                title:''<i>fit_intercept</i>''\n            },\n            style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q3").qtip({\n            content: {\n                text: ''The number of passes over the training data (aka epochs).'',\n                title:''<i>n_iter</i>''\n            },\n            style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q4").qtip({\n            content: {\n                text: ''Whether or not the training data should be shuffled after each epoch.'',\n                title:''<i>shuffle</i>''\n            },\n            style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q5").qtip({\n            content: {\n                text: ''Constant by which the updates are multiplied.'',\n                title:''<i>eta0</i>''\n            },\n            style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q6").qtip({\n            content: {\n                text: ''When set to True, reuse the solution of the previous call to fit as initialization, otherwise, just erase the previous solution.'',\n                title:''<i>warm_start</i>''\n            },\n            style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n    });\n</script>', '<h4 class="m-b-xxs text-center">Perceptron <i class="fa fa-mars-double"></i></h4><p>The perceptron is a type of linear classifier, i.e. a classification algorithm that makes its predictions based on a linear predictor function combining a set of weights with the feature vector. The algorithm allows for online learning, in that it processes elements in the training set one at a time. <a href="http://en.wikipedia.org/wiki/Perceptron" target="_blank"> [ref]</a></p><div class="col-xs-6"> <div> <span>Complexity</span> <small class="pull-right">4/10</small> </div> <div class="progress progress-small"> <div class="progress-bar" style="width: 40%;"> </div> </div></div><div class="col-xs-6"> <div> <span>Interpretability</span> <small class="pull-right">5/10</small> </div> <div class="progress progress-small"> <div class="progress-bar progress-bar-warning" style="width: 50%;"> </div> </div></div>'),
(4, 'classification', '{"n_neighbors":"int","weights":"string","algorithm":"string","leaf_size":"int","metric":"string"}', 'K-Nearest Neighbors', '<div class="row">\n    <div class="col-lg-2">\n        <label>Algorithm: <i class="fa fa-question-circle" id="q1" style=\n        "color:#676a6c"></i></label>\n\n        <div class="radio i-checks">\n            <label><input checked class="required" name="algorithm" type=\n            "radio" value="auto"> Auto</label>\n        </div>\n\n        <div class="radio i-checks">\n            <label><input class="required" name="algorithm" type="radio"\n            value="ball_tree"> ball_tree</label>\n        </div>\n\n        <div class="radio i-checks">\n            <label><input class="required" name="algorithm" type="radio"\n            value="kd_tree"> kd_tree</label>\n        </div>\n\n        <div class="radio i-checks">\n            <label><input class="required" name="algorithm" type="radio"\n            value="brute"> Brute-force</label>\n        </div>\n    </div>\n\n    <div class="col-lg-2">\n        <label>Weights: <i class="fa fa-question-circle" id="q2" style=\n        "color:#676a6c"></i></label>\n\n        <div class="radio i-checks">\n            <label><input checked class="required" name="weights" type=\n            "radio" value="uniform"> Uniform</label>\n        </div>\n\n        <div class="radio i-checks">\n            <label><input class="required" name="weights" type="radio"\n            value="distance"> Distance</label>\n        </div>\n    </div>\n\n    <div class="col-lg-4 text-center">\n        <div class="row text-center">\n            <label>n_neighbors = <span class="example-val" id=\n            "n_neighbors-value" style="color:#1AB394"></span> <i class=\n            "fa fa-question-circle" id="q3" style=\n            "color:#676a6c"></i></label>\n\n            <div class="col-lg-10 col-lg-offset-1">\n                <div id="n_neighbors-slider"></div><input id="n_neighbors"\n                name="n_neighbors" type="hidden" value="">\n            </div>\n        </div><br>\n        <label>metric: <i class="fa fa-question-circle" id="q4" style=\n        "color:#676a6c"></i></label> <select class="form-control required"\n        id="metric" name="metric">\n            <option value="minkowski">\n                Minkowski Distance\n            </option>\n\n            <option value="euclidean">\n                Euclidean Distance\n            </option>\n\n            <option value="manhattan">\n                Manhattan Distance\n            </option>\n\n            <option value="chebyshev">\n                Chebyshev Distance\n            </option>\n\n            <option value="hamming">\n                Hamming Distance\n            </option><script></script>\n        </select>\n    </div>\n\n    <div class="col-lg-4 text-center">\n        <div class="row text-center">\n            <label>leaf_size = <span class="example-val" id=\n            "leaf_size-value" style="color:#1AB394"></span> <i class=\n            "fa fa-question-circle" id="q5" style=\n            "color:#676a6c"></i></label>\n\n            <div class="col-lg-10 col-lg-offset-1">\n                <div id="leaf_size-slider"></div><input id="leaf_size"\n                name="leaf_size" type="hidden" value="">\n            </div>\n        </div>\n    </div>\n</div>\n<script>\n    $(document).ready(function() {\n        $(''.i-checks'').iCheck({\n            checkboxClass: ''icheckbox_square-green'',\n            radioClass: ''iradio_square-green'',\n        });\n\n        $(''#n_neighbors-slider'').noUiSlider({\n            start: [5],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [20]\n            }\n        });\n        $(''#n_neighbors-slider'').Link(''lower'').to($(''#n_neighbors-value''));\n        $(''#n_neighbors-slider'').Link(''lower'').to($(''#n_neighbors''));\n\n        $(''#leaf_size-slider'').noUiSlider({\n            start: [30],\n            step: 1,\n            connect: "lower",\n            range: {\n                ''min'': [1],\n                ''max'': [50]\n            }\n        });\n        $(''#leaf_size-slider'').Link(''lower'').to($(''#leaf_size-value''));\n        $(''#leaf_size-slider'').Link(''lower'').to($(''#leaf_size''));\n\n\n        $("#q1").qtip({\n            content: {\n                text: ''Algorithm used to compute the nearest neighbors.'',\n                title:''<i>algorithm</i>''\n            },\n            style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q2").qtip({\n            content: {\n                text: ''Weight function used in prediction.'',\n                title:''<i>weights</i>''\n            },\n            style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q3").qtip({\n            content: {\n                text: ''Number of neighbors to use by default for k_neighbors queries.'',\n                title:''<i>n_neighbors</i>''\n            },\n            style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q4").qtip({\n            content: {\n                text: ''The distance metric to use for computing closest neighbors. The default metric is minkowski, and with p=2 is equivalent to the standard Euclidean metric.'',\n                title:''<i>metric</i>''\n            },\n            style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n        $("#q5").qtip({\n            content: {\n                text: ''Leaf size passed to BallTree or KDTree. This can affect the speed of the construction and query, as well as the memory required to store the tree. The optimal value depends on the nature of the problem.'',\n                title:''<i>leaf_size</i>''\n            },\n            style: { classes: ''qtip-rounded qtip-shadow qtip-cream'' }\n        });\n    });\n</script>', '<h4 class="m-b-xxs text-center">K-Nearest Neighbor Classifier <i class=\n    "fa fa-connectdevelop"></i></h4>\n\n    <p>In k-NN classification, an instance is classified by a majority vote of\n    its neighbors, being assigned to the class most common\n    among its <i>k</i> nearest neighbors .<a href=\n    "http://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm" target=\n    "_blank">[ref]</a></p>\n\n    <div class="col-xs-6">\n        <div>\n            <span>Complexity</span> <small class="pull-right">2/10</small>\n        </div>\n\n        <div class="progress progress-small">\n            <div class="progress-bar" style="width: 20%;">\n            </div>\n        </div>\n    </div>\n\n    <div class="col-xs-6">\n        <div>\n            <span>Interpretability</span> <small class=\n            "pull-right">9/10</small>\n        </div>\n\n        <div class="progress progress-small">\n            <div class="progress-bar" style="width: 90%;"></div>\n        </div>\n    </div>');

-- --------------------------------------------------------

--
-- Table structure for table `ode_results`
--

CREATE TABLE IF NOT EXISTS `ode_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `params` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `runtime` double DEFAULT NULL,
  `finished` tinyint(1) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dataset` int(11) NOT NULL,
  `result` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `model` int(11) NOT NULL,
  `dataset_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

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
(2, 'user', 'user', 'user@email.com', 'user@email.com', 1, 'av2sn0ujazkgcok4s004og8o40gss8w', '170IfD1qEs26TVFKqwr3G0tGJxBZgopmNHdMaOkHuy0k8J5E/rffVtWBGQvVH5/g/Gg2mgxpR5lqGRmaMSPitg==', '2015-04-10 17:50:53', 0, 0, NULL, NULL, NULL, 'a:0:{}', 0, NULL, 'FirstName', 'LastName', 'University of Notre Dame', '2015-04-10 17:50:53', '/assets/profilepictures/ee11cbb19052e40b07aac0ca060c23ee');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
