<?php
namespace ODE\AnalysisBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class FormFlowController extends Controller {

    public function createAnalysisAction() {
        $em = $this->getDoctrine()->getManager();
        $datasets = $em->getRepository('ODEDatasetBundle:Dataset')->findAll();
        $models = $em->getRepository('ODEAnalysisBundle:Model')->findAll();
        return $this->render('ODEAnalysisBundle:Default:createAnalysis.html.twig', array(
            'datasets' => $datasets,
            'models' => $models,
        ));
    }

    public function getModelFormAction(Request $request){
        $model_id = $request->query->get('modelid');
        $em = $this->getDoctrine()->getManager();
        $model = $em->getRepository('ODEAnalysisBundle:Model')->find($model_id);

        return new Response($model->getForm());
    }
}