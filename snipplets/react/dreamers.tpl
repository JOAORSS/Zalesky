<div id="react-dreamers-section"></div>

<script>
window.addEventListener('load', function() {
    if (window.renderZaleskiDreamers) {
        
        var dreamersList = [];
        
        var configuredDreamers = [
            {
                image: "{{ 'dreamers_1_image.jpg' | static_url | escape('js') }}",
                username: "{{ settings.dreamers_1_username | escape('js') }}",
                url: "{{ settings.dreamers_1_url | escape('js') }}",
                hasImage: {{ 'dreamers_1_image.jpg' | has_custom_image ? 'true' : 'false' }}
            },
            {
                image: "{{ 'dreamers_2_image.jpg' | static_url | escape('js') }}",
                username: "{{ settings.dreamers_2_username | escape('js') }}",
                url: "{{ settings.dreamers_2_url | escape('js') }}",
                hasImage: {{ 'dreamers_2_image.jpg' | has_custom_image ? 'true' : 'false' }}
            },
            {
                image: "{{ 'dreamers_3_image.jpg' | static_url | escape('js') }}",
                username: "{{ settings.dreamers_3_username | escape('js') }}",
                url: "{{ settings.dreamers_3_url | escape('js') }}",
                hasImage: {{ 'dreamers_3_image.jpg' | has_custom_image ? 'true' : 'false' }}
            },
            {
                image: "{{ 'dreamers_4_image.jpg' | static_url | escape('js') }}",
                username: "{{ settings.dreamers_4_username | escape('js') }}",
                url: "{{ settings.dreamers_4_url | escape('js') }}",
                hasImage: {{ 'dreamers_4_image.jpg' | has_custom_image ? 'true' : 'false' }}
            },
            {
                image: "{{ 'dreamers_5_image.jpg' | static_url | escape('js') }}",
                username: "{{ settings.dreamers_5_username | escape('js') }}",
                url: "{{ settings.dreamers_5_url | escape('js') }}",
                hasImage: {{ 'dreamers_5_image.jpg' | has_custom_image ? 'true' : 'false' }}
            },
            {
                image: "{{ 'dreamers_6_image.jpg' | static_url | escape('js') }}",
                username: "{{ settings.dreamers_6_username | escape('js') }}",
                url: "{{ settings.dreamers_6_url | escape('js') }}",
                hasImage: {{ 'dreamers_6_image.jpg' | has_custom_image ? 'true' : 'false' }}
            }
        ];

        for (var i = 0; i < configuredDreamers.length; i++) {
            if (configuredDreamers[i].hasImage && configuredDreamers[i].username) {
                dreamersList.push(configuredDreamers[i]);
            }
        }

        var props = {
            title: "{{ settings.dreamers_title | default('Dreamers') | escape('js') }}",
            subtitle: "{{ settings.dreamers_subtitle | default('Nossas clientes usando Zaleski no dia a dia') | escape('js') }}",
            footerText: "{{ settings.dreamers_footer | default('Poste com #ZaleskiDream para aparecer aqui') | escape('js') }}",
            items: dreamersList
        };

        window.renderZaleskiDreamers('react-dreamers-section', props);
    }
});
</script>
