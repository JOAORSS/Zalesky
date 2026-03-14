<div id="react-trust-strip"></div>

<script>
window.addEventListener('load', function() {
    if (window.renderZaleskiTrustStrip) {
        var trustItems = [
            { icon: 'truck', text: "{{ settings.trust_text_1 | default('Frete grátis acima de R$500') | escape('js') }}" },
            { icon: 'shield', text: "{{ settings.trust_text_2 | default('Compra 100% segura') | escape('js') }}" },
            { icon: 'card', text: "{{ settings.trust_text_3 | default('Até 6x sem juros') | escape('js') }}" },
            { icon: 'pix', text: "{{ settings.trust_text_4 | default('5% OFF no PIX') | escape('js') }}" }
        ];
        
        window.renderZaleskiTrustStrip('react-trust-strip', { items: trustItems });
    }
});
</script>
