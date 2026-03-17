{% set breadcrumb_id = 'react-zaleski-breadcrumbs-' ~ random() %}
<div id="{{ breadcrumb_id }}"></div>

<script>
window.addEventListener('load', function() {
    if (window.renderZaleskiBreadcrumbs) {
        var breadcrumbItems = [];
        
        breadcrumbItems.push({
            name: "{{ 'Inicio' | translate | escape('js') }}",
            url: "{{ store.url | escape('js') }}"
        });

        {% for crumb in breadcrumbs %}
            breadcrumbItems.push({
                name: "{{ crumb.name | escape('js') }}",
                url: "{{ crumb.url | escape('js') }}"
            });
        {% endfor %}

        var props = {
            items: breadcrumbItems
        };

        window.renderZaleskiBreadcrumbs('{{ breadcrumb_id }}', props);
    }
});
</script>
