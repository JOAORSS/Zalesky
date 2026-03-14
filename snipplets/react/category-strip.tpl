<div id="react-category-strip"></div>

<script>
window.addEventListener('load', function() {
    if (window.renderZaleskiCategoryStrip) {
        var categoryItems = [];
        
        {% if settings.zaleski_category_title_1 and settings.zaleski_category_url_1 %}
        categoryItems.push({
            url: "{{ settings.zaleski_category_url_1 | escape('js') }}",
            image: "{{ 'zaleski_category_image_1.jpg' | static_url | escape('js') }}",
            title: "{{ settings.zaleski_category_title_1 | escape('js') }}"
        });
        {% endif %}

        {% if settings.zaleski_category_title_2 and settings.zaleski_category_url_2 %}
        categoryItems.push({
            url: "{{ settings.zaleski_category_url_2 | escape('js') }}",
            image: "{{ 'zaleski_category_image_2.jpg' | static_url | escape('js') }}",
            title: "{{ settings.zaleski_category_title_2 | escape('js') }}"
        });
        {% endif %}

        {% if settings.zaleski_category_title_3 and settings.zaleski_category_url_3 %}
        categoryItems.push({
            url: "{{ settings.zaleski_category_url_3 | escape('js') }}",
            image: "{{ 'zaleski_category_image_3.jpg' | static_url | escape('js') }}",
            title: "{{ settings.zaleski_category_title_3 | escape('js') }}"
        });
        {% endif %}

        {% if settings.zaleski_category_title_4 and settings.zaleski_category_url_4 %}
        categoryItems.push({
            url: "{{ settings.zaleski_category_url_4 | escape('js') }}",
            image: "{{ 'zaleski_category_image_4.jpg' | static_url | escape('js') }}",
            title: "{{ settings.zaleski_category_title_4 | escape('js') }}"
        });
        {% endif %}

        {% if settings.zaleski_category_title_5 and settings.zaleski_category_url_5 %}
        categoryItems.push({
            url: "{{ settings.zaleski_category_url_5 | escape('js') }}",
            image: "{{ 'zaleski_category_image_5.jpg' | static_url | escape('js') }}",
            title: "{{ settings.zaleski_category_title_5 | escape('js') }}"
        });
        {% endif %}

        window.renderZaleskiCategoryStrip('react-category-strip', { items: categoryItems });
    }
});
</script>
