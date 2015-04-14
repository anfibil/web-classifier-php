<?php

namespace ODE\AnalysisBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Result
 *
 * @ORM\Table(name="ode_results")
 * @ORM\Entity
 * @ORM\HasLifecycleCallbacks
 */
class Result
{
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var integer
     *
     * @ORM\Column(name="model", type="integer", length=255)
     */
    private $model;

    /**
     * @var array
     *
     * @ORM\Column(name="params", type="json_array", nullable=true)
     */
    private $params;

    /**
     * @var float
     *
     * @ORM\Column(name="runtime", type="float", nullable=true)
     */
    private $runtime;

    /**
     * @var boolean
     *
     * @ORM\Column(name="finished", type="boolean")
     */
    private $finished;

    /**
     * @var string
     *
     * @ORM\Column(name="username", type="string", length=255)
     */
    private $username;

    /**
     * @var integer
     *
     * @ORM\Column(name="dataset", type="integer",nullable=true)
     */
    private $dataset;

    /**
     * @var string
     *
     * @ORM\Column(name="dataset_name", type="string", length=255, nullable=true)
     */
    private $dataset_name;

    /**
     * @var float
     *
     * @ORM\Column(name="auroc", type="float", nullable=true)
     */
    private $auroc;

    /**
     * @var float
     *
     * @ORM\Column(name="aupr", type="float", nullable=true)
     */
    private $aupr;

    /**
     * @var float
     *
     * @ORM\Column(name="accuracy", type="float", nullable=true)
     */
    private $accuracy;

    /**
     * @var array
     *
     * @ORM\Column(name="report_data", type="json_array", nullable=true)
     */
    private $report_data;

    /**
     * @var string
     *
     * @ORM\Column(name="created_at", type="string", nullable=true)
     */
    private $created_at;

    function __construct()
    {
        $this->finished = false;
    }

    /**
     *  @ORM\PrePersist
     */
    public function doOnPrePersist()
    {
        $this->created_at = date('Y-m-d H:i:s');
    }

    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set algorithm
     *
     * @param integer $model
     * @return Result
     */
    public function setModel($model)
    {
        $this->model = $model;

        return $this;
    }

    /**
     * Get model
     *
     * @return integer
     */
    public function getModel()
    {
        return $this->model;
    }

    /**
     * Set parameters
     *
     * @param array $params
     * @return Result
     */
    public function setParams($params)
    {
        $this->params = $params;

        return $this;
    }

    /**
     * Get parameters
     *
     * @return array 
     */
    public function getParams()
    {
        return $this->params;
    }

    /**
     * Set runtime
     *
     * @param float $runtime
     * @return Result
     */
    public function setRuntime($runtime)
    {
        $this->runtime = $runtime;

        return $this;
    }

    /**
     * Get runtime
     *
     * @return float
     */
    public function getRuntime()
    {
        return $this->runtime;
    }

    /**
     * Set auroc
     *
     * @param float $auroc
     * @return Result
     */
    public function setAuroc($auroc)
    {
        $this->auroc = $auroc;

        return $this;
    }

    /**
     * Get auroc
     *
     * @return float
     */
    public function getAuroc()
    {
        return $this->auroc;
    }

    /**
     * Get aupr
     *
     * @return float
     */
    public function getAupr()
    {
        return $this->aupr;
    }

    /**
     * Set aupr
     *
     * @param float $aupr
     * @return Result
     */
    public function setAupr($aupr)
    {
        $this->aupr = $aupr;

        return $this;
    }

    /**
     * Get accuracy
     *
     * @return float
     */
    public function getAccuracy()
    {
        return $this->accuracy;
    }

    /**
     * Set accuracy
     *
     * @param float $accuracy
     * @return Result
     */
    public function setAccuracy($accuracy)
    {
        $this->accuracy = $accuracy;

        return $this;
    }

    /**
     * Set finished
     *
     * @param boolean $finished
     * @return Result
     */
    public function setFinished($finished)
    {
        $this->finished = $finished;

        return $this;
    }

    /**
     * Get finished
     *
     * @return boolean 
     */
    public function getFinished()
    {
        return $this->finished;
    }

    /**
     * Set username
     *
     * @param string $username
     * @return Result
     */
    public function setUsername($username)
    {
        $this->username = $username;

        return $this;
    }

    /**
     * Get username
     *
     * @return string 
     */
    public function getUsername()
    {
        return $this->username;
    }

    /**
     * Set dataset
     *
     * @param integer $dataset
     * @return Result
     */
    public function setDataset($dataset)
    {
        $this->dataset = $dataset;

        return $this;
    }

    /**
     * Get dataset
     *
     * @return integer
     */
    public function getDataset()
    {
        return $this->dataset;
    }

    /**
     * Set username
     *
     * @param string $dataset_name
     * @return Result
     */
    public function setDataset_name($dataset_name)
    {
        $this->dataset_name = $dataset_name;

        return $this;
    }

    /**
     * Get username
     *
     * @return string
     */
    public function getDataset_name()
    {
        return $this->dataset_name;
    }

    /**
     * Set report_data
     *
     * @param array $report_data
     * @return Result
     */
    public function setReport_data($report_data)
    {
        $this->report_data = $report_data;

        return $this;
    }

    /**
     * Get report_data
     *
     * @return array 
     */
    public function getReport_data()
    {
        return $this->report_data;
    }
}
