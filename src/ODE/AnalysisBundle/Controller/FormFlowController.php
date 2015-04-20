<?php
namespace ODE\AnalysisBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class FormFlowController extends Controller {

    public function createAnalysisAction() {
        $em = $this->getDoctrine()->getManager();
        $datasets = $em->getRepository('ODEDatasetBundle:Dataset')->findBy([], ['name' => 'ASC']);
        $models = $em->getRepository('ODEAnalysisBundle:Model')->findBy([], ['name' => 'ASC']);
        return $this->render('ODEAnalysisBundle:Default:createAnalysis.html.twig', array(
            'datasets' => $datasets,
            'models' => $models,
        ));
    }

    public function getModelFormAction(Request $request){
        $model_id = $request->query->get('modelid');
        $dataset_id = $request->query->get('datasetid');
        $em = $this->getDoctrine()->getManager();
        $model = $em->getRepository('ODEAnalysisBundle:Model')->find($model_id);
        $dataset = $em->getRepository('ODEDatasetBundle:Dataset')->find($dataset_id);

        $model_form = $model->getForm();
        $values = array("NUM_FEATURES","NUM_INSTANCES");
        $keys = array($dataset->getNumFeatures(),$dataset->getNumInstances());
        $model_form_html = str_replace($values, $keys, $model_form);

        return new Response($model_form_html);
    }
}