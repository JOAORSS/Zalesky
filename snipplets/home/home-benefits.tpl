{# 
  [ARQUIVO: snipplets/home/home-benefits.tpl]
  INSTRUÇÃO: Inclua em `templates/home.tpl` abaixo das seções de banner:
  {% include 'snipplets/home/home-benefits.tpl' %}
#}

{% if settings.show_benefits %}
<style>
    .zaleski-benefits {
        background-color: #f9f9f9;
        padding: 40px 0;
        border-top: 1px solid #eaeaea;
    }

    .zaleski-benefits .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    .zaleski-benefits-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 30px 15px;
    }

    @media (min-width: 768px) {
        .zaleski-benefits-grid {
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
    }

    .zaleski-benefit-item {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
        font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
    }

    .zaleski-icon {
        width: 28px;
        height: 28px;
        color: #1a1a1a;
        margin-bottom: 15px;
        object-fit: contain;
    }

    .zaleski-benefit-item span {
        font-size: 12px;
        color: #333333;
        letter-spacing: 0.5px;
        line-height: 1.4;
        text-transform: uppercase;
    }
</style>

<section class="zaleski-benefits">
    <div class="container">
        <div class="zaleski-benefits-grid">
            
            {# Benefício 1 #}
            <div class="zaleski-benefit-item">
                {% if "benefit_1_img.jpg" | has_custom_image %}
                    <img src="{{ "benefit_1_img.jpg" | static_url | image_url('100x') }}" class="zaleski-icon" alt="{{ settings.benefit_1_text }}">
                {% else %}
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="zaleski-icon"><path d="M5 18H3c-.6 0-1-.4-1-1V7c0-.6.4-1 1-1h10c.6 0 1 .4 1 1v11"></path><path d="M14 9h4l4 4v5c0 .6-.4 1-1 1h-2"></path><circle cx="7" cy="18" r="2"></circle><circle cx="17" cy="18" r="2"></circle></svg>
                {% endif %}
                <span>{{ settings.benefit_1_text }}</span>
            </div>

            {# Benefício 2 #}
            <div class="zaleski-benefit-item">
                {% if "benefit_2_img.jpg" | has_custom_image %}
                    <img src="{{ "benefit_2_img.jpg" | static_url | image_url('100x') }}" class="zaleski-icon" alt="{{ settings.benefit_2_text }}">
                {% else %}
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="zaleski-icon"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                {% endif %}
                <span>{{ settings.benefit_2_text }}</span>
            </div>

            {# Benefício 3 #}
            <div class="zaleski-benefit-item">
                {% if "benefit_3_img.jpg" | has_custom_image %}
                    <img src="{{ "benefit_3_img.jpg" | static_url | image_url('100x') }}" class="zaleski-icon" alt="{{ settings.benefit_3_text }}">
                {% else %}
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="zaleski-icon"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect><line x1="1" y1="10" x2="23" y2="10"></line></svg>
                {% endif %}
                <span>{{ settings.benefit_3_text }}</span>
            </div>

            {# Benefício 4 #}
            <div class="zaleski-benefit-item">
                {% if "benefit_4_img.jpg" | has_custom_image %}
                    <img src="{{ "benefit_4_img.jpg" | static_url | image_url('100x') }}" class="zaleski-icon" alt="{{ settings.benefit_4_text }}">
                {% else %}
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="zaleski-icon"><path d="M12 2l4 4-4 4-4-4 4-4zM12 14l4 4-4 4-4-4 4-4zM2 12l4-4 4 4-4 4-4-4zM14 12l4-4 4 4-4 4-4-4z"></path></svg>
                {% endif %}
                <span>{{ settings.benefit_4_text }}</span>
            </div>

        </div>
    </div>
</section>
{% endif %}