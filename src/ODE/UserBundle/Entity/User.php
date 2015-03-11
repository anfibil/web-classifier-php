<?php

namespace ODE\UserBundle\Entity;

use FOS\UserBundle\Model\User as BaseUser;
use Doctrine\ORM\Mapping as ORM;
//use Symfony\Component\Security\Core\Util\SecureRandom;
use Symfony\Component\Validator\Constraints as Assert;
use Symfony\Component\HttpFoundation\File\UploadedFile;

/**
 * @ORM\Entity
 * @ORM\Table(name="ode_user")
 * @ORM\HasLifecycleCallbacks
 */
class User extends BaseUser
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;

    /**
     * @ORM\Column(type="string", length=255)
     *
     * @Assert\NotBlank(message="Please enter your name.", groups={"Registration", "Profile"})
     * @Assert\Length(
     *     min=2,
     *     max="255",
     *     minMessage="The name is too short.",
     *     maxMessage="The name is too long.",
     *     groups={"Registration", "Profile"}
     * )
     */
    protected $firstname;

    /**
     * @ORM\Column(type="string", length=255)
     *
     * @Assert\NotBlank(message="Please enter your name.", groups={"Registration", "Profile"})
     * @Assert\Length(
     *     min=2,
     *     max="255",
     *     minMessage="The name is too short.",
     *     maxMessage="The name is too long.",
     *     groups={"Registration", "Profile"}
     * )
     */
    protected $lastname;

    /**
     * @ORM\Column(type="string", length=255)
     *
     * @Assert\NotBlank(message="Please enter your affiliation.", groups={"Registration", "Profile"})
     * @Assert\Length(
     *     min=3,
     *     max="255",
     *     minMessage="The affiliation name is too short.",
     *     maxMessage="The affiliation name is too long.",
     *     groups={"Registration", "Profile"}
     * )
     */
    protected $affiliation;

    /**
     * @ORM\Column(type="datetime")
     */
    protected $lastEdited;

    /**
     * @Assert\File(maxSize="8192k")
     * @Assert\Image(mimeTypesMessage="Please upload a valid image.")
     */
    protected $profilePictureFile;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    protected $profilePicturePath;

    public function __construct()
    {
        parent::__construct();
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

    public function getFirstname()
    {
        return $this->firstname;
    }

    public function  setFirstname($firstname)
    {
        $this->firstname = $firstname;
        return $this;
    }

        public function getLastname()
    {
        return $this->lastname;
    }

    public function setLastname($lastname)
    {
        $this->lastname = $lastname;
        return $this;
    }

    public function getAffiliation()
    {
        return $this->affiliation;
    }

    public function setAffiliation($affiliation)
    {
        $this->affiliation = $affiliation;
        return $this;
    }

    public function setProfilePictureFile(UploadedFile $file = null) {
        $this->profilePictureFile = $file;
        return $this;
    }

    public function getProfilePictureFile() {

        return $this->profilePictureFile;
    }

    public function setProfilePicturePath($profilePicturePath)
    {
        $this->profilePicturePath = $profilePicturePath;

        return $this;
    }

    public function getProfilePicturePath()
    {
        return $this->profilePicturePath;
    }

    public function getAbsolutePath()
    {
        return null === $this->profilePicturePath
            ? null
            : $this->getUploadRootDir().'/'.$this->profilePicturePath;
    }

    public function getWebPath()
    {
        return null === $this->profilePicturePath
            ? null
            : $this->getUploadDir().'/'.$this->profilePicturePath;
    }

    protected function getUploadRootDir()
    {
        // The absolute directory path where uploaded
        // documents should be saved.
        return __DIR__.'/../../../../web/'.$this->getUploadDir();
    }

    protected function getUploadDir()
    {
        // Remove the __DIR__ so the uploaded doc/image
        // displays correctly.
        return '/assets/profilepictures/';
    }

    public function upload()
    {
        // The file property can be empty if the field is not required.
        if (null === $this->getProfilePictureFile()) {
            return;
        }

        // Create unique filename for this user.
        $uniqueFileName = md5($this->username);

        // Get the profile picture file.
        $file = $this->getProfilePictureFile();

        // Move and name the file.
        /* @var $file \Symfony\Component\HttpFoundation\File\UploadedFile */
        $file->move(
            $this->getUploadRootDir(),
            $uniqueFileName
        );

        // Set the path property to the filename where you've saved the file.
        $this->profilePicturePath = $this->getUploadDir().$uniqueFileName;

        // Clean up the file property, as no longer needed.
        $this->profilePictureFile = null;
    }


    public function setLastEdited($lastEdited)
    {
        $this->lastEdited = $lastEdited;

        return $this;
    }

    public function getLastEdited()
    {
        return $this->lastEdited;
    }

    // --------------------//
    // Lifecycle Callbacks //
    // --------------------//

    /**
     * @ORM\PrePersist()
     * @ORM\PreUpdate()
     */
    public function setLastEditedValueAsNow() {
        //TODO: This does not seem to be updating the database
        $this->setLastEdited(new \DateTime());
    }

    /**
     * @ORM\PrePersist()
     */
    public function setDefaultProfilePicture(){
        // Create a default profile picture for new users based on anonymous.jpg file
        $this->profilePicturePath = '/assets/profilepictures/'.md5($this->username);
        copy(__DIR__.'/../../../../web/assets/img/anonymous.jpg',__DIR__.'/../../../../web'.$this->profilePicturePath);
    }
}
