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
     * @ORM\ManyToOne(targetEntity="Model", inversedBy="results")
     * @ORM\JoinColumn(name="model_id", referencedColumnName="id")
     */
    private $model;

    /**
     * @ORM\ManyToOne(targetEntity="ODE\DatasetBundle\Entity\Dataset", inversedBy="results")
     * @ORM\JoinColumn(name="dataset_id", referencedColumnName="id")
     */
    private $dataset;

    /**
     * @ORM\ManyToOne(targetEntity="ODE\UserBundle\Entity\User", inversedBy="results")
     * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
     */
    private $user;

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
     * @ORM\Column(name="date", type="string", nullable=true)
     */
    private $date;

    // ----------//
    // Construct //
    // ----------//

    function __construct()
    {
        $this->finished = false;
    }

    // --------------------//
    // Lifecycle Callbacks //
    // --------------------//

    /**
     *  @ORM\PrePersist
     */
    public function doOnPrePersist()
    {
        $this->date = date('Y-m-d H:i:s');
    }

    // --------------------//
    // Getters and Setters //
    // --------------------//

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

    public function setUser($user)
    {
        $this->user = $user;

        return $this;
    }
    public function getUser()
    {
        return $this->user;
    }

    public function setModel($model)
    {
        $this->model = $model;

        return $this;
    }
    public function getModel()
    {
        return $this->model;
    }

    public function setDataset($dataset)
    {
        $this->dataset = $dataset;

        return $this;
    }
    public function getDataset()
    {
        return $this->dataset;
    }
    public function getDate()
    {
        return $this->date;
    }
}
