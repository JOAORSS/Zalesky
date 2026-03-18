{% include 'snipplets/page-header.tpl' with { breadcrumbs: true } %}

<div id="react-zaleski-product-details"></div>

<script>
(function() {
    function initProductDetails() {
        if (window.renderZaleskiProductDetails) {
            
            var imagesList = [];
            {% for image in product.images %}
                imagesList.push({
                    url: "{{ image | product_image_url('original') | escape('js') }}",
                    thumbUrl: "{{ image | product_image_url('large') | escape('js') }}",
                    alt: "{{ product.name | escape('js') }}"
                });
            {% endfor %}

            var installmentsStr = "";
            {% if product.installments_info %}
                installmentsStr = "ou {{ product.installments_info.quantity }}x de {{ product.installments_info.installment_amount | money }}";
                {% if not product.installments_info.has_interest %}
                    installmentsStr += " sem juros";
                {% endif %}
            {% endif %}

            var props = {
                images: imagesList,
                product: {
                    name: "{{ product.name | escape('js') }}",
                    price: "{{ product.price | money | escape('js') }}",
                    comparePrice: {% if product.compare_at_price > product.price %}"{{ product.compare_at_price | money | escape('js') }}"{% else %}null{% endif %},
                    installments: installmentsStr,
                    badge: {% if 'novo' in product.tags %} "Novo" {% else %} null {% endif %}
                }
            };

            window.renderZaleskiProductDetails('react-zaleski-product-details', props);
        }
    }

    if (document.readyState !== 'loading') initProductDetails();
    else document.addEventListener('DOMContentLoaded', initProductDetails);
})();
</script>

<script>
(function() {
    function initPDP() {
        if (window.renderZaleskiProductDetails) {
            var imagesList = [];
            {% for image in product.images %}
                imagesList.push({
                    url: "{{ image | product_image_url('original') | escape('js') }}",
                    thumbUrl: "{{ image | product_image_url('large') | escape('js') }}",
                    alt: "{{ product.name | escape('js') }}"
                });
            {% endfor %}

            {% set inst_count = settings.pdp_installments_count | default(6) %}
            {% set inst_val = product.price / inst_count %}
            var installmentsStr = "ou {{ inst_count }}x de {{ inst_val | money }} sem juros";

            var propsDetails = {
                images: imagesList,
                product: {
                    name: "{{ product.name | escape('js') }}",
                    price: "{{ product.price | money | escape('js') }}",
                    comparePrice: {% if product.compare_at_price > product.price %}"{{ product.compare_at_price | money | escape('js') }}"{% else %}null{% endif %},
                    installments: installmentsStr,
                    badge: {% if 'novo' in product.tags %} "Novo" {% else %} null {% endif %}
                }
            };
            window.renderZaleskiProductDetails('react-zaleski-product-details', propsDetails);
        }

        if (window.renderZaleskiProductVariants) {
            var variationsList = [];
            {% if product.variations %}
                {% for variation in product.variations %}
                    var optionsList = [];
                    {% for option in variation.options %}
                        optionsList.push({
                            name: "{{ option.name | escape('js') }}",
                            customData: "{{ option.custom_data | default('') | escape('js') }}"
                        });
                    {% endfor %}
                    variationsList.push({
                        name: "{{ variation.name | escape('js') }}",
                        options: optionsList
                    });
                {% endfor %}
            {% endif %}

            {% set tags_str = product.tags | join(',') | lower %}
            var propsVariants = {
                variations: variationsList,
                scarcityText: {% if 'vendendo rápido' in tags_str or 'vendendo rapido' in tags_str %}"Vendendo rápido!"{% else %}null{% endif %}
            };

            var chkVar = setInterval(function() {
                if (document.getElementById('react-zaleski-pdp-variants')) {
                    clearInterval(chkVar);
                    window.renderZaleskiProductVariants('react-zaleski-pdp-variants', propsVariants);
                }
            }, 50);
        }

        if (window.renderZaleskiProductActions) {
            var benefitsArr = [];
            {% if settings.pdp_benefit_1 %} benefitsArr.push({ htmlContent: "{{ settings.pdp_benefit_1 | escape('js') }}" }); {% endif %}
            {% if settings.pdp_benefit_2 %} benefitsArr.push({ htmlContent: "{{ settings.pdp_benefit_2 | escape('js') }}" }); {% endif %}
            {% if settings.pdp_benefit_3 %} benefitsArr.push({ htmlContent: "{{ settings.pdp_benefit_3 | escape('js') }}" }); {% endif %}

            var propsActions = {
                formId: "product_form",
                personalizationText: "{{ settings.pdp_personalization_text | default('Precisa de ajustes? Saiba sobre personalização') | escape('js') }}",
                benefits: benefitsArr
            };
            var chkAct = setInterval(function() {
                if (document.getElementById('react-zaleski-pdp-buy-button')) {
                    clearInterval(chkAct);
                    window.renderZaleskiProductActions('react-zaleski-pdp-buy-button', propsActions);
                }
            }, 50);
        }

        if (window.renderZaleskiProductAccordion) {
            var accProps = {
                items: [
                    { title: "Detalhes", content: "{{ product.description | escape('js') }}" },
                    { title: "Tecido e Ajuste", content: "{{ settings.pdp_fabric | default('Adicione a info nas configurações.') | escape('js') }}" },
                    { title: "Entrega e Trocas", content: "{{ settings.pdp_shipping | default('Adicione a info nas configurações.') | escape('js') }}" }
                ]
            };
            var chkAcc = setInterval(function() {
                if (document.getElementById('react-zaleski-pdp-accordion')) {
                    clearInterval(chkAcc);
                    window.renderZaleskiProductAccordion('react-zaleski-pdp-accordion', accProps);
                }
            }, 50);
        }

        if (window.renderZaleskiProductShipping) {
            var chkShip = setInterval(function() {
                if (document.getElementById('react-zaleski-pdp-shipping')) {
                    clearInterval(chkShip);
                    window.renderZaleskiProductShipping('react-zaleski-pdp-shipping');
                }
            }, 50);
        }

        if (window.renderZaleskiProductCrossSell) {
            var crossProps = { main: null, related: null };
            
            {% set cross_sell_product = null %}
            {% if complementary_product_list | length > 0 %}
                {% set cross_sell_product = complementary_product_list | first %}
            {% endif %}

            console.log({{ cross_sell_product | json_encode }});

            {% if cross_sell_product %}
                crossProps = {
                    main: {
                        id: {{ product.id }},
                        name: "{{ product.name | escape('js') }}",
                        price: {{ product.price / 100 }},
                        priceFormatted: "{{ product.price | money | escape('js') }}",
                        comparePrice: {% if product.compare_at_price > product.price %}"{{ product.compare_at_price | money | escape('js') }}"{% else %}null{% endif %},
                        imgUrl: "{{ product.featured_image | product_image_url('medium') | escape('js') }}"
                    },
                    related: {
                        id: {{ cross_sell_product.id }},
                        name: "{{ cross_sell_product.name | escape('js') }}",
                        price: {{ cross_sell_product.price / 100 }},
                        priceFormatted: "{{ cross_sell_product.price | money | escape('js') }}",
                        imgUrl: "{{ cross_sell_product.featured_image | product_image_url('medium') | escape('js') }}"
                    }
                };
            {% else %}
                {# Se não tiver produto complementar, ativa nosso Fallback de Resumo de Conversão #}
                crossProps = {
                    main: {
                        id: {{ product.id }},
                        name: "{{ product.name | escape('js') }}",
                        price: {{ product.price / 100 }},
                        priceFormatted: "{{ product.price | money | escape('js') }}",
                        comparePrice: {% if product.compare_at_price > product.price %}"{{ product.compare_at_price | money | escape('js') }}"{% else %}null{% endif %},
                        imgUrl: "{{ product.featured_image | product_image_url('medium') | escape('js') }}"
                    },
                    related: null
                };
            {% endif %}

            var chkCross = setInterval(function() {
                if (document.getElementById('react-zaleski-pdp-cross-sell')) {
                    clearInterval(chkCross);
                    window.renderZaleskiProductCrossSell('react-zaleski-pdp-cross-sell', crossProps);
                }
            }, 50);
        }

        if (window.renderZaleskiPersonalizationModal) {
            var modalProps = {
                instagramUrl: "{{ settings.pdp_personalization_link | default(store.instagram) | escape('js') }}",
                contentHtml: "{{ settings.pdp_personalization_content | default('<p>Cada peça pode ser ajustada para ficar perfeita em você.</p>') | escape('js') }}"
            };
            var chkModal = setInterval(function() {
                if (document.getElementById('react-zaleski-pdp-personalization-modal')) {
                    clearInterval(chkModal);
                    window.renderZaleskiPersonalizationModal('react-zaleski-pdp-personalization-modal', modalProps);
                }
            }, 50);
        }
    }

    if (document.readyState !== 'loading') initPDP();
    else document.addEventListener('DOMContentLoaded', initPDP);
})();
</script>

<div id="react-zaleski-pdp-personalization-modal"></div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}
