<?php

namespace ODE\DatasetBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
//use Vich\UploaderBundle\Mapping\Annotation as Vich;
use Symfony\Component\HttpFoundation\File\UploadedFile;

/**
 * @ORM\Entity(repositoryClass="ODE\DatasetBundle\Entity\DatasetRepository")
 * @ORM\Table(name="ode_dataset")
 */
class Dataset
{
    /**
    * NOTE: This is not a mapped field of entity metadata, just a simple property.
    *
    * @var UploadedFile $file
    */
    protected $file;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    public $path;

    /**
     * @ORM\Column(type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;

    /**
     * @ORM\Column(type="string", length=255, name="name")
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

    /**
     * @ORM\OneToMany(targetEntity="ODE\AnalysisBundle\Entity\Result", mappedBy="dataset")
     */
    protected $results;

    // ----------//
    // Construct //
    // ----------//

    public function __construct()
    {
        $this->results = new ArrayCollection();
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

    public function getResults()
    {
        return $this->results;
    }

    private $temp;

    /**
     * Sets file.
     *
     * @param UploadedFile $file
     */
    public function setFile(UploadedFile $file = null)
    {
        $this->file = $file;
        // Check if we have an old file path.
        if (isset($this->path)) {
            // Store the old name to delete after the update.
            $this->temp = $this->path;
            $this->path = null;
        } else {
            $this->path = 'initial';
        }
    }

    /**
     * Get file.
     *
     * @return UploadedFile
     */
    public function getFile()
    {
        return $this->file;
    }

    public function getAbsolutePath()
    {
        return null === $this->path
            ? null
            : $this->getUploadRootDir().'/'.$this->path;
    }

    public function getWebPath()
    {
        return null === $this->path
            ? null
            : $this->getUploadDir().'/'.$this->path;
    }

    protected function getUploadRootDir()
    {
        // the absolute directory path where uploaded
        // documents should be saved
        return __DIR__.'/../../../../web/'.$this->getUploadDir();
    }

    protected function getUploadDir()
    {
        // get rid of the __DIR__ so it doesn't screw up
        // when displaying uploaded doc/image in the view.
        return 'uploads/documents';
    }

    /**
     * @ORM\PrePersist()
     * @ORM\PreUpdate()
     */
    public function preUpload()
    {
        if (null !== $this->getFile()) {
            // do whatever you want to generate a unique name
            $filename = sha1(uniqid(mt_rand(), true));
            $this->path = $filename.'.'.$this->getFile()->guessExtension();
        }
    }

    /**
     * @ORM\PostPersist()
     * @ORM\PostUpdate()
     */
    public function upload()
    {
        if (null === $this->getFile()) {
            return;
        }

        // if there is an error when moving the file, an exception will
        // be automatically thrown by move(). This will properly prevent
        // the entity from being persisted to the database on error
        $this->getFile()->move($this->getUploadRootDir(), $this->path);

        // check if we have an old image
        if (isset($this->temp)) {
            // delete the old image
            unlink($this->getUploadRootDir().'/'.$this->temp);
            // clear the temp image path
            $this->temp = null;
        }
        $this->file = null;
    }

    /**
     * @ORM\PostRemove()
     */
    public function removeUpload()
    {
        $file = $this->getAbsolutePath();
        if ($file) {
            unlink($file);
        }
    }
}
