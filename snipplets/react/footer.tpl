<div id="react-zaleski-footer"></div>

<script>
window.addEventListener('load', function() {
    if (window.renderZaleskiFooter) {
        
        var menu1Links = [];
        {% if settings.zaleski_footer_menu_1 %}
            {% for item in menus[settings.zaleski_footer_menu_1] %}
                menu1Links.push({ text: "{{ item.name | escape('js') }}", url: "{{ item.url | escape('js') }}" });
            {% endfor %}
        {% endif %}

        var menu2Links = [];
        {% if settings.zaleski_footer_menu_2 %}
            {% for item in menus[settings.zaleski_footer_menu_2] %}
            
                menu2Links.push({ text: "{{ item.name | escape('js') }}", url: "{{ item.url | escape('js') }}" });
            {% endfor %}
        {% endif %}

        var props = {
            newsletter: {
                show: {{ settings.zaleski_show_newsletter ? 'true' : 'false' }},
                title: "{{ settings.zaleski_nl_title | default('Junte-se às Dreamers') | escape('js') }}",
                subtitle: "{{ settings.zaleski_nl_subtitle | default('Receba novidades, lançamentos e ofertas exclusivas direto no seu e-mail.') | escape('js') }}",
                placeholder: "{{ settings.zaleski_nl_placeholder | default('Seu melhor e-mail') | escape('js') }}",
                buttonText: "{{ settings.zaleski_nl_button | default('Inscrever') | escape('js') }}"
            },
            menu1: {
                title: "{{ settings.zaleski_footer_title_1 | default('Categorias') | escape('js') }}",
                links: menu1Links
            },
            menu2: {
                title: "{{ settings.zaleski_footer_title_2 | default('Informações') | escape('js') }}",
                links: menu2Links
            },
            contact: {
                title: "{{ settings.zaleski_footer_contact_title | default('Entre em contato') | escape('js') }}",
                email: "{{ settings.zaleski_footer_email | default('contato@zaleski.com.br') | escape('js') }}",
                instagram: "{{ settings.zaleski_footer_instagram | default('#') | escape('js') }}",
                facebook: "{{ settings.zaleski_footer_facebook | default('#') | escape('js') }}",
                followersText: "{{ settings.zaleski_footer_followers | default('+14k seguidores no Instagram') | escape('js') }}"
            },
            payment: {
                title: "{{ settings.zaleski_footer_payment_title | default('Pagamento') | escape('js') }}",
                trustText: "{{ settings.zaleski_footer_trust_text | default('Compre com confiança — site 100% seguro') | escape('js') }}",
                icons: "{{ settings.zaleski_footer_payment_icons | default('Visa, Mastercard, Amex, Elo, Pix, Boleto') | escape('js') }}".split(',').map(function(i){ return i.trim(); })
            },
            copyright: "{{ settings.zaleski_footer_copyright | default('Copyright Zaleski Arte Artigos do Vestuário Ltda — 40729894000170 — 2026. Todos os direitos reservados.') | escape('js') }}",
            footerImage: "{{ 'images/Nextt.png' | static_url }}"
        };

        window.renderZaleskiFooter('react-zaleski-footer', props);
    }
});
</script>
