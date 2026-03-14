{% set section_id = 'react-shop-by-color-' ~ random() %}

<div id="{{ section_id }}"></div>

<script>
window.addEventListener('load', function() {
    if (window.renderZaleskiShopByColor) {
        var colorsList = [];

        var configuredColors = [
            { name: "{{ settings.zaleski_color_1_name | escape('js') }}", hex: "{{ settings.zaleski_color_1_hex | escape('js') }}" },
            { name: "{{ settings.zaleski_color_2_name | escape('js') }}", hex: "{{ settings.zaleski_color_2_hex | escape('js') }}" },
            { name: "{{ settings.zaleski_color_3_name | escape('js') }}", hex: "{{ settings.zaleski_color_3_hex | escape('js') }}" },
            { name: "{{ settings.zaleski_color_4_name | escape('js') }}", hex: "{{ settings.zaleski_color_4_hex | escape('js') }}" },
            { name: "{{ settings.zaleski_color_5_name | escape('js') }}", hex: "{{ settings.zaleski_color_5_hex | escape('js') }}" },
            { name: "{{ settings.zaleski_color_6_name | escape('js') }}", hex: "{{ settings.zaleski_color_6_hex | escape('js') }}" }
        ];

        for (var i = 0; i < configuredColors.length; i++) {
            if (configuredColors[i].name && configuredColors[i].hex) {
                colorsList.push(configuredColors[i]);
            }
        }

        var fallbackColors = [
            { name: "Baunilha", hex: "#f0e6d3" },
            { name: "Caramelo", hex: "#c4a882" },
            { name: "Vinho", hex: "#6b2c3e" },
            { name: "Preto", hex: "#111111" }
        ];

        var finalColors = colorsList.length > 0 ? colorsList : fallbackColors;

        var props = {
            title: "{{ settings.zaleski_shop_by_color_title | default('Escolha por cor') | escape('js') }}",
            viewAllUrl: "{{ settings.zaleski_shop_by_color_url | default('/produtos') | escape('js') }}",
            colors: finalColors
        };

        window.renderZaleskiShopByColor('{{ section_id }}', props);
    }
});
</script>
