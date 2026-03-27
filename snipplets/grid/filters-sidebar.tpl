<div id="react-zaleski-filters-sidebar"></div>

{% set has_insta_colors = false %}
{% for filter in product_filters %}
    {% for value in filter.values %}
        {% if value.color_type == 'insta_color' and value.color_hexa %}
            {% set has_insta_colors = true %}
        {% endif %}
    {% endfor %}
{% endfor %}

{% if has_insta_colors %}
<script id="zaleski-colors-data" type="application/json">
{% set comma = false %}
[
{% for filter in product_filters %}
    {% for value in filter.values %}
        {% if value.color_type == 'insta_color' and value.color_hexa %}
            {% if comma %},{% endif %}
            {"name": "{{ value.name | escape('js') }}", "hex": "{{ value.color_hexa | escape('js') }}"}
            {% set comma = true %}
        {% endif %}
    {% endfor %}
{% endfor %}
]
</script>
{% endif %}

<script>
(function() {
    function initSidebar() {
        if (window.renderZaleskiFilterSidebar) {
            var categoriesList = [];
            {% if filter_categories is not empty %}
                {% for category in filter_categories %}
                    categoriesList.push({
                        name: "{{ category.name | escape('js') }}",
                        url: "{{ category.url | escape('js') }}"
                    });
                {% endfor %}
            {% endif %}

            var filtersList = [];
            {% if product_filters is not empty %}
                {% for filter in product_filters %}
                    var filterValues = [];
                    {% for value in filter.values %}
                        filterValues.push({
                            name: "{{ value.name | escape('js') }}",
                            count: {{ value.product_count | default(0) }},
                            selected: {{ value.selected ? 'true' : 'false' }},
                            colorHexa: "{{ value.color_hexa | default('') | escape('js') }}"
                        });
                    {% endfor %}
                    
                    filtersList.push({
                        key: "{{ filter.key | escape('js') }}",
                        name: "{{ filter.name | escape('js') }}",
                        type: "{{ filter.type | escape('js') }}",
                        values: filterValues
                    });
                {% endfor %}
            {% endif %}

            var props = {
                categories: categoriesList,
                filters: filtersList
            };

            window.renderZaleskiFilterSidebar('react-zaleski-filters-sidebar', props);
        }
    }

    if (document.readyState !== 'loading') initSidebar();
    else document.addEventListener('DOMContentLoaded', initSidebar);
})();
</script>