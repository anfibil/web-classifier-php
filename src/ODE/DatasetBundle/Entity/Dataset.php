<?php

namespace ODE\DatasetBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="ODE\DatasetBundle\Entity\DatasetRepository")
 * @ORM\Table(name="ode_dataset")
 * @ORM\HasLifecycleCallbacks
 */
class Dataset
{
    /**
     * @ORM\Column(type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;

    /**
     * @ORM\Column(type="string", length=100)
     */
    protected $name;

    /**
     * @ORM\Column(type="text")
     */
    protected $description;

    /**
     * @ORM\Column(type="integer")
     */
    protected $num_instances;

    /**
     * @ORM\Column(type="integer")
     */
    protected $num_features;

    /**
     * @ORM\Column(type="text")
     */
    protected $filetype;

    /**
     * @ORM\Column(type="bigint")
     */
    protected $filesize;

    /**
     * @ORM\Column(type="text")
     */
    protected $filename;

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
     * Set name
     *
     * @param string $name
     * @return Dataset
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get name
     *
     * @return string 
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set description
     *
     * @param string $description
     * @return Dataset
     */
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * Get description
     *
     * @return string 
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Set num_instances
     *
     * @param integer $numInstances
     * @return Dataset
     */
    public function setNumInstances($numInstances)
    {
        $this->num_instances = $numInstances;

        return $this;
    }

    /**
     * Get num_instances
     *
     * @return integer 
     */
    public function getNumInstances()
    {
        return $this->num_instances;
    }

    /**
     * Set num_features
     *
     * @param integer $numFeatures
     * @return Dataset
     */
    public function setNumFeatures($numFeatures)
    {
        $this->num_features = $numFeatures;

        return $this;
    }

    /**
     * Get num_features
     *
     * @return integer 
     */
    public function getNumFeatures()
    {
        return $this->num_features;
    }

    /**
     * Set filetype
     *
     * @param string $filetype
     * @return Dataset
     */
    public function setFiletype($filetype)
    {
        $this->filetype = $filetype;

        return $this;
    }

    /**
     * Get filetype
     *
     * @return string 
     */
    public function getFiletype()
    {
        return $this->filetype;
    }

    /**
     * Set filesize
     *
     * @param integer $filesize
     * @return Dataset
     */
    public function setFilesize($filesize)
    {
        $this->filesize = $filesize;

        return $this;
    }

    /**
     * Get filesize
     *
     * @return integer 
     */
    public function getFilesize()
    {
        return $this->filesize;
    }

    /**
     * Set filename
     *
     * @param string $filename
     * @return Dataset
     */
    public function setFilename($filename)
    {
        $this->filename = $filename;

        return $this;
    }

    /**
     * Get filename
     *
     * @return string 
     */
    public function getFilename()
    {
        return $this->filename;
    }
}
