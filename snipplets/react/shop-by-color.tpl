<div id="react-shop-by-color"></div>

<script>
window.addEventListener('load', function() {
    if (window.renderZaleskiShopByColor) {
        window.renderZaleskiShopByColor('react-shop-by-color', {
            title: "{{ settings.zaleski_shop_by_color_title | default('Escolha por cor') | escape('js') }}"
        });
    }
});
</script>
