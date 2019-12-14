<?php


namespace App\Controller;

use App\Entity\Presentation;
use Symfony\Component\HttpFoundation\Response;
// Use auto router 
use Symfony\Component\Routing\Annotation\Route;
// Use render function
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class currentEvents extends AbstractController
{
    
    /**
     * @Route("/current")
     */
    public function getCurrentEventsPage()
    {
        $events = $this->getDoctrine()->
        getRepository(Presentation::class)->findAll();
        return $this->render('current/current.html.twig', [
            'events' => $events,
        ]);
    }
}