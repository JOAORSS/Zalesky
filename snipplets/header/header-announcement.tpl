{# 
  [ARQUIVO: snipplets/header/header-announcement.tpl]
  INSTRUÇÃO: Inclua este arquivo no `layouts/layout.tpl` logo após abrir a tag <body>:
  {% include 'snipplets/header/header-announcement.tpl' %}
#}

{% if settings.show_announcement_bar %}
<style>
    .zaleski-marquee {
        width: 100%;
        background-color: {{ settings.color_marquee_bg | default('#1a1a1a') }};
        color: {{ settings.color_marquee_text | default('#ffffff') }};
        overflow: hidden;
        white-space: nowrap;
        padding: 8px 0;
        position: relative;
        z-index: 1000;
        display: flex;
        align-items: center;
    }

    .zaleski-marquee-track {
        display: inline-block;
        animation: zaleskiMarquee {{ settings.marquee_speed | default('25s') }} linear infinite;
        font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
        font-size: 11px;
        letter-spacing: 1.5px;
        text-transform: uppercase;
    }

    .zaleski-marquee-track span {
        margin: 0 15px;
        font-weight: 500;
    }

    .zaleski-marquee-track span.zaleski-dot {
        opacity: 0.5;
        font-size: 8px;
        vertical-align: middle;
    }

    @keyframes zaleskiMarquee {
        0% { transform: translateX(0); }
        100% { transform: translateX(-50%); }
    }
</style>

<div class="zaleski-marquee">
    <div class="zaleski-marquee-track">
        <span>{{ settings.announcement_text_1 }}</span>
        <span class="zaleski-dot">•</span>
        <span>{{ settings.announcement_text_2 }}</span>
        <span class="zaleski-dot">•</span>
        <span>{{ settings.announcement_text_3 }}</span>
        <span class="zaleski-dot">•</span>
        <span>{{ settings.announcement_text_4 }}</span>
        <span class="zaleski-dot">•</span>
        
        <span>{{ settings.announcement_text_1 }}</span>
        <span class="zaleski-dot">•</span>
        <span>{{ settings.announcement_text_2 }}</span>
        <span class="zaleski-dot">•</span>
        <span>{{ settings.announcement_text_3 }}</span>
        <span class="zaleski-dot">•</span>
        <span>{{ settings.announcement_text_4 }}</span>
        <span class="zaleski-dot">•</span>
    </div>
</div>
{% endif %}