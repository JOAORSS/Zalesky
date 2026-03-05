{# snipplets/header/zaleski-announcement-bar.tpl #}

{% if settings.show_announcement_bar %}
    {% set marquee_speed = settings.marquee_speed | default: '25s' %}
    
    <style>
        /* CSS crítico local para a barra de anúncio (Marquee) */
        .zaleski-marquee-container {
            width: 100%;
            overflow: hidden;
            padding: 10px 0;
            position: relative;
            z-index: 1010; /* Garante que fique acima do header original */
            display: flex;
            box-sizing: border-box;
        }
        
        .zaleski-marquee-content {
            display: flex;
            flex-shrink: 0;
            min-width: 100%;
            /* A animação translada exatos 50% da largura (que contém 2 grupos idênticos) */
            animation: zaleskiMarquee {{ marquee_speed }} linear infinite;
        }
        
        .zaleski-marquee-group {
            display: flex;
            flex-shrink: 0;
            min-width: 100vw;
            justify-content: space-around;
            gap: 2rem;
            padding-right: 2rem; /* Mantém o espaçamento no loop */
        }
        
        .zaleski-marquee-item {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 2rem;
            white-space: nowrap;
        }
        
        /* Separador visual entre as mensagens */
        .zaleski-marquee-item::after {
            content: "·";
            font-weight: 700;
        }
        
        /* Pausa a animação quando o usuário passa o mouse */
        .zaleski-marquee-container:hover .zaleski-marquee-content {
            animation-play-state: paused;
        }
        
        @keyframes zaleskiMarquee {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }
    </style>

    {# Container principal com as cores inseridas via inline style dinâmico conforme regra #}
    <div class="zaleski-marquee-container" style="background: {{ settings.color_marquee_bg | default: '#000000' }}; color: {{ settings.color_marquee_text | default: '#ffffff' }};">
        <div class="zaleski-marquee-content">
            
            {# Renderiza o grupo 2 vezes para criar a ilusão de rolagem infinita contínua sem JS #}
            {% for i in (1..2) %}
            <div class="zaleski-marquee-group" {% if loop.index == 2 %}aria-hidden="true"{% endif %}>
                {% if settings.announcement_text_1 %}
                    <div class="zaleski-marquee-item">{{ settings.announcement_text_1 }}</div>
                {% endif %}
                {% if settings.announcement_text_2 %}
                    <div class="zaleski-marquee-item">{{ settings.announcement_text_2 }}</div>
                {% endif %}
                {% if settings.announcement_text_3 %}
                    <div class="zaleski-marquee-item">{{ settings.announcement_text_3 }}</div>
                {% endif %}
                {% if settings.announcement_text_4 %}
                    <div class="zaleski-marquee-item">{{ settings.announcement_text_4 }}</div>
                {% endif %}
            </div>
            {% endfor %}
            
        </div>
    </div>
{% endif %}