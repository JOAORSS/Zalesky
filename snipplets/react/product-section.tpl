{# Precisamos de um ID dinâmico caso tenhamos mais de uma vitrine na página #}
{% set section_id = 'react-product-section-' ~ random() %}

<div id="{{ section_id }}"></div>

<script>
window.addEventListener('load', function() {
    if (window.renderZaleskiProductSection) {
        var productsList = [];
        
        {# Assumindo que você passa uma coleção de produtos do Twig para este snipplet como 'section_products' #}
        {% for product in section_products %}
            {% if loop.index <= 8 %} {# Limitando a 8 produtos para não pesar #}
                
                {# Lógica de Tag/Badge do Twig #}
                {% set badge_text = '' %}
                {% if product.promotional_offer %}
                    {% set badge_text = 'Oferta' %}
                {% elseif product.free_shipping %}
                    {% set badge_text = 'Frete Grátis' %}
                {% else %}
                    {# Fallback ou tag customizada #}
                    {% set badge_text = 'Best Seller' %}
                {% endif %}

                productsList.push({
                    url: "{{ product.url | escape('js') }}",
                    image: "{{ product.featured_image | product_image_url('large') | escape('js') }}",
                    name: "{{ product.name | escape('js') }}",
                    price: "{{ product.price | money | escape('js') }}",
                    {% if badge_text %}
                    badge: "{{ badge_text | escape('js') }}"
                    {% endif %}
                });
            {% endif %}
        {% endfor %}

        var sectionProps = {
            title: "{{ section_title | default('Nossos Produtos') | escape('js') }}",
            viewAllUrl: "{{ section_url | default('#') | escape('js') }}",
            products: productsList
        };

        window.renderZaleskiProductSection('{{ section_id }}', sectionProps);
    }
});
</script>
