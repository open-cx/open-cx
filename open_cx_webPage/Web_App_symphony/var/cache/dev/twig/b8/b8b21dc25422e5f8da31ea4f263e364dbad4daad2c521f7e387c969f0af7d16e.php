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

/* incoming/incoming.html.twig */
class __TwigTemplate_051a854ba41997cdda3947519522e61940e41a5ad7cbddb606d9dbbe3e997394 extends \Twig\Template
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
        $__internal_085b0142806202599c7fe3b329164a92397d8978207a37e79d70b8c52599e33e->enter($__internal_085b0142806202599c7fe3b329164a92397d8978207a37e79d70b8c52599e33e_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "incoming/incoming.html.twig"));

        $__internal_319393461309892924ff6e74d6d6e64287df64b63545b994e100d4ab223aed02 = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_319393461309892924ff6e74d6d6e64287df64b63545b994e100d4ab223aed02->enter($__internal_319393461309892924ff6e74d6d6e64287df64b63545b994e100d4ab223aed02_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "incoming/incoming.html.twig"));

        // line 1
        echo "<html>
<head>
    <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\" integrity=\"sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T\" crossorigin=\"anonymous\">
    <script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js\" integrity=\"sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM\" crossorigin=\"anonymous\"></script>
    <script src=\"https://unpkg.com/leaflet@1.5.1/dist/leaflet.js\"
            integrity=\"sha512-GffPMF3RvMeYyc1LWMHtK8EbPv0iNZ8/oTtHPx9/cc2ILxQ+u905qIwdpULaqDkyBKgOaB57QTMg7ztg8Jm2Og==\"
            crossorigin=\"\"></script>
    <link rel=\"stylesheet\" href=\"";
        // line 8
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("css/main.css"), "html", null, true);
        echo "\" />
</head>
<body>
<h1>
    <nav class=\"navbar navbar-expand-sm bg-light\">
        <div class=\"container-fluid\">
            <div class=\"navbar-header\">
                <a class=\"navbar-brand\" href=\"#\">Confmark</a>
            </div>
        </div>
        <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">

            <ul class=\"navbar-nav mr-auto\">

                <li class=\"nav-item\">
                    <h4>";
        // line 23
        echo twig_escape_filter($this->env, twig_date_format_filter($this->env, "now", "m/d/Y H:i:s"), "html", null, true);
        echo "</h4>
                </li>
            </ul>

        </div>
    </nav>
    <div class=\"container-fluid\">
        <table class=\"table\">
            <thead class=\"thead-dark\">
            <tr>
                <th scope=\"col\">#</th>
                <th scope=\"col\">Speaker 1</th>
                <th scope=\"col\">Speaker 2</th>
                <th scope=\"col\">Speaker 3</th>
                <th scope=\"col\">Room</th>
                <th scope=\"col\">Title of the presentation</th>
                <th scope=\"col\">Summary</th>
                <th scope=\"col\">Start time</th>
                <th scope=\"col\">End time</th>
                <th scope=\"col\">hashtag</th>
            </tr>
            </thead>
            <tbody>
            ";
        // line 46
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable((isset($context["events"]) || array_key_exists("events", $context) ? $context["events"] : (function () { throw new RuntimeError('Variable "events" does not exist.', 46, $this->source); })()));
        foreach ($context['_seq'] as $context["_key"] => $context["event"]) {
            // line 47
            echo "                <tr>
                    <td>";
            // line 48
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "id", [], "any", false, false, false, 48), "html", null, true);
            echo "</td>
                    <td>";
            // line 49
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "idspeaker1", [], "any", false, false, false, 49), "html", null, true);
            echo "</td>
                    <td>";
            // line 50
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "idspeaker2", [], "any", false, false, false, 50), "html", null, true);
            echo "</td>
                    <td>";
            // line 51
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "idspeaker3", [], "any", false, false, false, 51), "html", null, true);
            echo "</td>
                    <td>";
            // line 52
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "idroom", [], "any", false, false, false, 52), "html", null, true);
            echo "</td>
                    <td>";
            // line 53
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "title", [], "any", false, false, false, 53), "html", null, true);
            echo "</td>
                    <td>";
            // line 54
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "summary", [], "any", false, false, false, 54), "html", null, true);
            echo "</td>
                    <td>";
            // line 55
            echo twig_escape_filter($this->env, twig_date_format_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "starttime", [], "any", false, false, false, 55), "Y-m-d"), "html", null, true);
            echo "</td>
                    <td>";
            // line 56
            echo twig_escape_filter($this->env, twig_date_format_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "endtime", [], "any", false, false, false, 56), "Y-m-d"), "html", null, true);
            echo "</td>
                    <td>";
            // line 57
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["event"], "hashtag", [], "any", false, false, false, 57), "html", null, true);
            echo "</td>
                </tr>
            ";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['event'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 60
        echo "            </tbody>
        </table>
    </div>
</h1>
</body>
</html>";
        
        $__internal_085b0142806202599c7fe3b329164a92397d8978207a37e79d70b8c52599e33e->leave($__internal_085b0142806202599c7fe3b329164a92397d8978207a37e79d70b8c52599e33e_prof);

        
        $__internal_319393461309892924ff6e74d6d6e64287df64b63545b994e100d4ab223aed02->leave($__internal_319393461309892924ff6e74d6d6e64287df64b63545b994e100d4ab223aed02_prof);

    }

    public function getTemplateName()
    {
        return "incoming/incoming.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  148 => 60,  139 => 57,  135 => 56,  131 => 55,  127 => 54,  123 => 53,  119 => 52,  115 => 51,  111 => 50,  107 => 49,  103 => 48,  100 => 47,  96 => 46,  70 => 23,  52 => 8,  43 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("<html>
<head>
    <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\" integrity=\"sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T\" crossorigin=\"anonymous\">
    <script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js\" integrity=\"sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM\" crossorigin=\"anonymous\"></script>
    <script src=\"https://unpkg.com/leaflet@1.5.1/dist/leaflet.js\"
            integrity=\"sha512-GffPMF3RvMeYyc1LWMHtK8EbPv0iNZ8/oTtHPx9/cc2ILxQ+u905qIwdpULaqDkyBKgOaB57QTMg7ztg8Jm2Og==\"
            crossorigin=\"\"></script>
    <link rel=\"stylesheet\" href=\"{{ asset('css/main.css') }}\" />
</head>
<body>
<h1>
    <nav class=\"navbar navbar-expand-sm bg-light\">
        <div class=\"container-fluid\">
            <div class=\"navbar-header\">
                <a class=\"navbar-brand\" href=\"#\">Confmark</a>
            </div>
        </div>
        <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">

            <ul class=\"navbar-nav mr-auto\">

                <li class=\"nav-item\">
                    <h4>{{ \"now\"|date(\"m/d/Y H:i:s\") }}</h4>
                </li>
            </ul>

        </div>
    </nav>
    <div class=\"container-fluid\">
        <table class=\"table\">
            <thead class=\"thead-dark\">
            <tr>
                <th scope=\"col\">#</th>
                <th scope=\"col\">Speaker 1</th>
                <th scope=\"col\">Speaker 2</th>
                <th scope=\"col\">Speaker 3</th>
                <th scope=\"col\">Room</th>
                <th scope=\"col\">Title of the presentation</th>
                <th scope=\"col\">Summary</th>
                <th scope=\"col\">Start time</th>
                <th scope=\"col\">End time</th>
                <th scope=\"col\">hashtag</th>
            </tr>
            </thead>
            <tbody>
            {% for event in events %}
                <tr>
                    <td>{{ event.id }}</td>
                    <td>{{ event.idspeaker1 }}</td>
                    <td>{{ event.idspeaker2 }}</td>
                    <td>{{ event.idspeaker3 }}</td>
                    <td>{{ event.idroom }}</td>
                    <td>{{ event.title }}</td>
                    <td>{{ event.summary }}</td>
                    <td>{{ event.starttime |date('Y-m-d')}}</td>
                    <td>{{ event.endtime |date('Y-m-d')}}</td>
                    <td>{{ event.hashtag }}</td>
                </tr>
            {% endfor %}
            </tbody>
        </table>
    </div>
</h1>
</body>
</html>", "incoming/incoming.html.twig", "C:\\Users\\Operator1\\Documents\\GitHub\\open-cx-sg1\\open-cx-sg\\web_app\\sg_wp\\templates\\incoming\\incoming.html.twig");
    }
}
