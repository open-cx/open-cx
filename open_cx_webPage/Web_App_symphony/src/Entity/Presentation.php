<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="App\Repository\PresentationRepository")
 */
class Presentation
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(type="integer")
     */
    private $id;
    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $title;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $summary;
    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $start_time;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $end_time;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $hashtag;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\Room", inversedBy="Presentations")
     * @ORM\JoinColumn(nullable=false)
     */
    private $room;

    /**
     * @ORM\ManyToMany(targetEntity="App\Entity\Speaker", inversedBy="Presentations")
     */
    private $speaker;

    public function __construct()
    {
        $this->speaker = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }
    public function getTitle()
    {
        return $this->title;
    }

    public function setTitle($title)
    {
        $this->title = $title;

        return $this;
    }

    public function getSummary()
    {
        return $this->summary;
    }

    public function setSummary($summary)
    {
        $this->summary = $summary;

        return $this;
    }

    public function getStartTime()
    {
        return $this->start_time;
    }

    public function setStartTime( $start_time)
    {
        $this->start_time = $start_time;

        return $this;
    }

    public function getEndTime()
    {
        return $this->end_time;
    }

    public function setEndTime($end_time)
    {
        $this->end_time = $end_time;

        return $this;
    }

    public function getHashtag()
    {
        return $this->hashtag;
    }

    public function setHashtag($hashtag)
    {
        $this->hashtag = $hashtag;

        return $this;
    }

    public function getRoom(): ?room
    {
        return $this->room;
    }

    public function setRoom(?room $room): self
    {
        $this->room = $room;

        return $this;
    }

    /**
     * @return Collection|speaker[]
     */
    public function getSpeaker(): Collection
    {
        return $this->speaker;
    }

    public function addSpeaker(speaker $speaker): self
    {
        if (!$this->speaker->contains($speaker)) {
            $this->speaker[] = $speaker;
        }

        return $this;
    }

    public function removeSpeaker(speaker $speaker): self
    {
        if ($this->speaker->contains($speaker)) {
            $this->speaker->removeElement($speaker);
        }

        return $this;
    }
}
