{% set section_id = 'react-category-carousel-' ~ random() %}

<div id="{{ section_id }}"></div>

<script>
window.addEventListener('load', function() {
    if (window.renderZaleskiCarousel) {
        var temaCategories = [];
        var otherCategories = [];

        {% for category in categories %}
            {% if category.description and '[TEMA]' in category.description %}
                temaCategories.push({
                    url: "{{ category.url | escape('js') }}",
                    image: "{{ category.images | first | category_image_url('original') | default('') | escape('js') }}",
                    title: "{{ category.name | escape('js') }}"
                });
            {% else %}
                otherCategories.push({
                    url: "{{ category.url | escape('js') }}",
                    image: "{{ category.images | first | category_image_url('original') | default('') | escape('js') }}",
                    title: "{{ category.name | escape('js') }}"
                });
            {% endif %}
        {% endfor %}

        var finalCategories = temaCategories.slice(0, 4);

        if (finalCategories.length < 4) {
            for (var i = 0; i < otherCategories.length && finalCategories.length < 4; i++) {
                finalCategories.push(otherCategories[i]);
            }
        }

        if (finalCategories.length > 0) {
            var sectionProps = {
                title: "{{ 'Categorias' | translate | escape('js') }}",
                variant: "category",
                items: finalCategories
            };

            window.renderZaleskiCarousel('{{ section_id }}', sectionProps);
        }
    }
});
</script>
