<?php

namespace App\Controller;

use App\Entity\Presentation;
use Symfony\Component\HttpFoundation\Response;
// Use auto router 
use Symfony\Component\Routing\Annotation\Route;
// Use render function
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;


class IncomingEvents extends AbstractController 
{
    
    /**
     * @Route("/incoming")
     */
    public function getIncomingEventsPage()
    {
        $events = $this->getDoctrine()->
        getRepository(Presentation::class)->findAll();
        return $this->render('incoming/incoming.html.twig', [
            'events' => $events,
        ]);
    }
}