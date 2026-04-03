<div id="react-shop-by-color"></div>

<script>
window.addEventListener('load', function() {
    if (window.renderZaleskiShopByColor) {
        window.renderZaleskiShopByColor('react-shop-by-color', {
            title: "{{ settings.zaleski_shop_by_color_title | default('Escolha por cor') | escape('js') }}",
            customColors: [
                { name: "{{ settings.zaleski_color_1_name | escape('js') }}", hex: "{{ settings.zaleski_color_1_hex | escape('js') }}" },
                { name: "{{ settings.zaleski_color_2_name | escape('js') }}", hex: "{{ settings.zaleski_color_2_hex | escape('js') }}" },
                { name: "{{ settings.zaleski_color_3_name | escape('js') }}", hex: "{{ settings.zaleski_color_3_hex | escape('js') }}" },
                { name: "{{ settings.zaleski_color_4_name | escape('js') }}", hex: "{{ settings.zaleski_color_4_hex | escape('js') }}" },
                { name: "{{ settings.zaleski_color_5_name | escape('js') }}", hex: "{{ settings.zaleski_color_5_hex | escape('js') }}" },
                { name: "{{ settings.zaleski_color_6_name | escape('js') }}", hex: "{{ settings.zaleski_color_6_hex | escape('js') }}" }
            ]
        });
    }
});
</script>
