<div id="react-about-section"></div>

<script>
window.addEventListener('load', function() {
    if (window.renderZaleskiAbout) {
        var defaultDescription = '<p>Cada peça é confeccionada de forma individual, especialmente para você. Contamos com ateliê próprio e uma equipe dedicada, comprometida em transformar seus desejos em realidade.</p>' +
            '<p style="color: #666;">✓ Sem estoque — feito especialmente para você</p>' +
            '<p style="color: #666;">✓ Ateliê próprio com equipe dedicada</p>' +
            '<p style="color: #666;">✓ Tradição familiar desde 2020</p>';

        var props = {
            title: "{{ settings.about_title | default('Feito sob demanda em Porto Alegre.') | escape('js') }}",
            description: "{{ settings.about_description | default('') | escape('js') }}" || defaultDescription,
            linkText: "{{ settings.about_link_text | default('Conheça nossa história →') | escape('js') }}",
            linkUrl: "{{ settings.about_link_url | default('#') | escape('js') }}",
            stampTop: "{{ settings.about_stamp_top | default('Feito em Porto Alegre') | escape('js') }}",
            stampBottom: "{{ settings.about_stamp_bottom | default('desde 2020') | escape('js') }}"
        };

        window.renderZaleskiAbout('react-about-section', props);
    }
});
</script>
