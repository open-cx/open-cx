<?php

use Twig\Environment;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Extension\SandboxExtension;
use Twig\Markup;
use Twig\Sandbox\SecurityError;
use Twig\Sandbox\SecurityNotAllowedTagError;
use Twig\Sandbox\SecurityNotAllowedFilterError;
use Twig\Sandbox\SecurityNotAllowedFunctionError;
use Twig\Source;
use Twig\Template;

/* current/current.html.twig */
class __TwigTemplate_344b1af9578381a97d6e4bfab4fff474e8ed493fb2fca0f8fc185620380bfddc extends \Twig\Template
{
    private $source;
    private $macros = [];

    public function __construct(Environment $env)
    {
        parent::__construct($env);

        $this->source = $this->getSourceContext();

        $this->parent = false;

        $this->blocks = [
        ];
    }

    protected function doDisplay(array $context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_085b0142806202599c7fe3b329164a92397d8978207a37e79d70b8c52599e33e = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_085b0142806202599c7fe3b329164a92397d8978207a37e79d70b8c52599e33e->enter($__internal_085b0142806202599c7fe3b329164a92397d8978207a37e79d70b8c52599e33e_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "current/current.html.twig"));

        $__internal_319393461309892924ff6e74d6d6e64287df64b63545b994e100d4ab223aed02 = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_319393461309892924ff6e74d6d6e64287df64b63545b994e100d4ab223aed02->enter($__internal_319393461309892924ff6e74d6d6e64287df64b63545b994e100d4ab223aed02_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "current/current.html.twig"));

        // line 1
        echo "<!doctype html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <script>document.getElementsByTagName(\"html\")[0].className += \" js\";</script>
    <link rel=\"stylesheet\" href=\"";
        // line 7
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("css/style.css"), "html", null, true);
        echo "\">
    <title>Current events</title>
</head>
<body>
<header class=\"cd-main-header text-center flex flex-column flex-center\">
    

    <h1 class=\"text-xl\">Current events</h1>
</header>

<div class=\"cd-schedule cd-schedule--loading margin-top-lg margin-bottom-lg js-cd-schedule\">
    <div class=\"cd-schedule__timeline\">
        <ul>
            <li><span>09:00</span></li>
            <li><span>09:30</span></li>
            <li><span>10:00</span></li>
            <li><span>10:30</span></li>
            <li><span>11:00</span></li>
            <li><span>11:30</span></li>
            <li><span>12:00</span></li>
            <li><span>12:30</span></li>
            <li><span>13:00</span></li>
            <li><span>13:30</span></li>
            <li><span>14:00</span></li>
            <li><span>14:30</span></li>
            <li><span>15:00</span></li>
            <li><span>15:30</span></li>
            <li><span>16:00</span></li>
            <li><span>16:30</span></li>
            <li><span>17:00</span></li>
            <li><span>17:30</span></li>
            <li><span>18:00</span></li>
        </ul>
    </div> <!-- .cd-schedule__timeline -->
    <div class=\"cd-schedule__events\">
        <ul>
            <li class=\"cd-schedule__group\">
                <div class=\"cd-schedule__top-info\"><span>Monday</span></div>
                <ul>
                ";
        // line 46
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable((isset($context["events"]) || array_key_exists("events", $context) ? $context["events"] : (function () { throw new RuntimeError('Variable "events" does not exist.', 46, $this->source); })()));
        foreach ($context['_seq'] as $context["_key"] => $context["event"]) {
            // line 47
            echo "            <li class=\"cd-schedule__event\">
              <a data-start=\"";
            // line 48
            echo twig_escape_filter($this->env, twig_date_format_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "starttime", [], "any", false, false, false, 48), "H:i:s"), "html", null, true);
            echo "\" data-end=\"";
            echo twig_escape_filter($this->env, twig_date_format_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "endtime", [], "any", false, false, false, 48), "H:i:s"), "html", null, true);
            echo "\" data-content=\"event-abs-circuit\" data-event=\"event-1\" href=\"#0\">
                <em class=\"cd-schedule__name\">";
            // line 49
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "title", [], "any", false, false, false, 49), "html", null, true);
            echo "</em>
                <em class=\"cd-schedule__name\">";
            // line 50
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "idspeaker1", [], "any", false, false, false, 50), "html", null, true);
            echo "</em>
              </a>
            </li>
                
                
                              
            </li>
            ";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['event'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 57
        echo " 
        </ul>
    </div>
    <div class=\"cd-schedule-modal\">
        <header class=\"cd-schedule-modal__header\">
            <div class=\"cd-schedule-modal__content\">
                <span class=\"cd-schedule-modal__date\"></span>
                <h3 class=\"cd-schedule-modal__name\"></h3>
            </div>

            <div class=\"cd-schedule-modal__header-bg\"></div>
        </header>

        <div class=\"cd-schedule-modal__body\">
            <div class=\"cd-schedule-modal__event-info\"></div>
            <div class=\"cd-schedule-modal__body-bg\"></div>
        </div>

        <a href=\"#0\" class=\"cd-schedule-modal__close text-replace\">Close</a>
    </div>

    <div class=\"cd-schedule__cover-layer\"></div>
</div> <!-- .cd-schedule -->

<script src=\"";
        // line 81
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("js/util.js"), "html", null, true);
        echo "\"></script> <!-- util functions included in the CodyHouse framework -->
<script src=\"";
        // line 82
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("js/main.js"), "html", null, true);
        echo "\"></script>
</body>
</html>";
        
        $__internal_085b0142806202599c7fe3b329164a92397d8978207a37e79d70b8c52599e33e->leave($__internal_085b0142806202599c7fe3b329164a92397d8978207a37e79d70b8c52599e33e_prof);

        
        $__internal_319393461309892924ff6e74d6d6e64287df64b63545b994e100d4ab223aed02->leave($__internal_319393461309892924ff6e74d6d6e64287df64b63545b994e100d4ab223aed02_prof);

    }

    public function getTemplateName()
    {
        return "current/current.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  154 => 82,  150 => 81,  124 => 57,  110 => 50,  106 => 49,  100 => 48,  97 => 47,  93 => 46,  51 => 7,  43 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("<!doctype html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <script>document.getElementsByTagName(\"html\")[0].className += \" js\";</script>
    <link rel=\"stylesheet\" href=\"{{ asset('css/style.css') }}\">
    <title>Current events</title>
</head>
<body>
<header class=\"cd-main-header text-center flex flex-column flex-center\">
    

    <h1 class=\"text-xl\">Current events</h1>
</header>

<div class=\"cd-schedule cd-schedule--loading margin-top-lg margin-bottom-lg js-cd-schedule\">
    <div class=\"cd-schedule__timeline\">
        <ul>
            <li><span>09:00</span></li>
            <li><span>09:30</span></li>
            <li><span>10:00</span></li>
            <li><span>10:30</span></li>
            <li><span>11:00</span></li>
            <li><span>11:30</span></li>
            <li><span>12:00</span></li>
            <li><span>12:30</span></li>
            <li><span>13:00</span></li>
            <li><span>13:30</span></li>
            <li><span>14:00</span></li>
            <li><span>14:30</span></li>
            <li><span>15:00</span></li>
            <li><span>15:30</span></li>
            <li><span>16:00</span></li>
            <li><span>16:30</span></li>
            <li><span>17:00</span></li>
            <li><span>17:30</span></li>
            <li><span>18:00</span></li>
        </ul>
    </div> <!-- .cd-schedule__timeline -->
    <div class=\"cd-schedule__events\">
        <ul>
            <li class=\"cd-schedule__group\">
                <div class=\"cd-schedule__top-info\"><span>Monday</span></div>
                <ul>
                {% for event in events %}
            <li class=\"cd-schedule__event\">
              <a data-start=\"{{ event.starttime |date('H:i:s')}}\" data-end=\"{{ event.endtime |date('H:i:s')}}\" data-content=\"event-abs-circuit\" data-event=\"event-1\" href=\"#0\">
                <em class=\"cd-schedule__name\">{{event.title}}</em>
                <em class=\"cd-schedule__name\">{{ event.idspeaker1 }}</em>
              </a>
            </li>
                
                
                              
            </li>
            {% endfor %} 
        </ul>
    </div>
    <div class=\"cd-schedule-modal\">
        <header class=\"cd-schedule-modal__header\">
            <div class=\"cd-schedule-modal__content\">
                <span class=\"cd-schedule-modal__date\"></span>
                <h3 class=\"cd-schedule-modal__name\"></h3>
            </div>

            <div class=\"cd-schedule-modal__header-bg\"></div>
        </header>

        <div class=\"cd-schedule-modal__body\">
            <div class=\"cd-schedule-modal__event-info\"></div>
            <div class=\"cd-schedule-modal__body-bg\"></div>
        </div>

        <a href=\"#0\" class=\"cd-schedule-modal__close text-replace\">Close</a>
    </div>

    <div class=\"cd-schedule__cover-layer\"></div>
</div> <!-- .cd-schedule -->

<script src=\"{{ asset('js/util.js') }}\"></script> <!-- util functions included in the CodyHouse framework -->
<script src=\"{{ asset('js/main.js') }}\"></script>
</body>
</html>", "current/current.html.twig", "C:\\Users\\Operator1\\Documents\\GitHub\\open-cx-sg1\\open-cx-sg\\web_app\\sg_wp\\templates\\current\\current.html.twig");
    }
}
