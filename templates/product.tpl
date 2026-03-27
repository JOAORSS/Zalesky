<section class="container-fluid mt-3 d-md-none">
    {% include "snipplets/breadcrumbs.tpl" %}
</section>
<div class="d-none d-md-block">
    {% include "snipplets/breadcrumbs.tpl" %}
</div>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/photoswipe@5.3.8/dist/photoswipe.css">
<script>
    window.ZALESKI_CART_URL = "{{ store.cart_url }}";
    window.ZALESKI_PRODUCT_ID = "{{ product.id }}";
</script>

<div id="react-zaleski-product-details"></div>

<script>
(function() {
    function initPDP() {
        // 1. PRODUCT DETAILS
        var chkDetails = setInterval(function() {
            if (window.renderZaleskiProductDetails) {
                clearInterval(chkDetails);
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
                var installmentsStr = "ou {{ inst_count }}x de {{ inst_val | money | escape('js') }} sem juros";

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
        }, 50);

        // --- 1. VARIANTES E MAPA DE IDs ---
        if (window.renderZaleskiProductVariants) {
            var variationsList = [];
            {% if product.variations %}
                {% for variation in product.variations %}
                    var optionsList = [];
                    {% for option in variation.options %}
                        optionsList.push({
                            id: "{{ option.id }}",
                            name: "{{ option.name | escape('js') }}",
                            customData: "{{ option.custom_data | default('') | escape('js') }}"
                        });
                    {% endfor %}
                    variationsList.push({
                        id: "{{ variation.id }}",
                        name: "{{ variation.name | escape('js') }}",
                        options: optionsList
                    });
                {% endfor %}
            {% endif %}
            window.ZALESKI_VARIATIONS_LIST = variationsList;

            var variantsMap = [];
            {% for variant in product.variants %}
                var varOpts = [];
                {% if variant.option0 %}varOpts.push("{{ variant.option0 | escape('js') }}");{% endif %}
                {% if variant.option1 %}varOpts.push("{{ variant.option1 | escape('js') }}");{% endif %}
                {% if variant.option2 %}varOpts.push("{{ variant.option2 | escape('js') }}");{% endif %}

                variantsMap.push({
                    id: {{ variant.id }},
                    options: varOpts,
                    price: {{ variant.price / 100 }},
                    priceFormatted: "{{ variant.price | money | escape('js') }}"
                });
            {% endfor %}

            window.ZALESKI_VARIANTS_MAP = variantsMap;

            {% set tags_str = product.tags | join(',') | lower %}
            var propsVariants = {
                variations: variationsList,
                variantsMap: variantsMap,
                scarcityText: {% if 'vendendo rápido' in tags_str or 'vendendo rapido' in tags_str %}"Vendendo rápido!"{% else %}null{% endif %}
            };

            var chkVar = setInterval(function() {
                if (document.getElementById('react-zaleski-pdp-variants')) {
                    clearInterval(chkVar);
                    window.renderZaleskiProductVariants('react-zaleski-pdp-variants', propsVariants);
                }
            }, 50);
        }

        // 3. ACTIONS
        var chkAct = setInterval(function() {
            if (window.renderZaleskiProductActions && document.getElementById('react-zaleski-pdp-buy-button')) {
                clearInterval(chkAct);
                var benefitsArr = [];
                {% if settings.pdp_benefit_1 %} benefitsArr.push({ htmlContent: "{{ settings.pdp_benefit_1 | escape('js') }}" }); {% endif %}
                {% if settings.pdp_benefit_2 %} benefitsArr.push({ htmlContent: "{{ settings.pdp_benefit_2 | escape('js') }}" }); {% endif %}
                {% if settings.pdp_benefit_3 %} benefitsArr.push({ htmlContent: "{{ settings.pdp_benefit_3 | escape('js') }}" }); {% endif %}

                var propsActions = {
                    formId: "product_form",
                    personalizationText: "{{ settings.pdp_personalization_text | default('Precisa de ajustes? Saiba sobre personalização') | escape('js') }}",
                    benefits: benefitsArr
                };
                window.renderZaleskiProductActions('react-zaleski-pdp-buy-button', propsActions);
            }
        }, 50);

        // 4. ACCORDION
        var chkAcc = setInterval(function() {
            if (window.renderZaleskiProductAccordion && document.getElementById('react-zaleski-pdp-accordion')) {
                clearInterval(chkAcc);
                var accProps = {
                    items: [
                        { title: "Detalhes", content: "{{ product.description | escape('js') }}" },
                        { title: "Tecido e Ajuste", content: "{{ settings.pdp_fabric | default('Adicione a info nas configurações.') | escape('js') }}" },
                        { title: "Entrega e Trocas", content: "{{ settings.pdp_shipping | default('Adicione a info nas configurações.') | escape('js') }}" }
                    ]
                };
                window.renderZaleskiProductAccordion('react-zaleski-pdp-accordion', accProps);
            }
        }, 50);

        // 5. SHIPPING
        var chkShip = setInterval(function() {
            if (window.renderZaleskiProductShipping && document.getElementById('react-zaleski-pdp-shipping')) {
                clearInterval(chkShip);
                window.renderZaleskiProductShipping('react-zaleski-pdp-shipping');
            }
        }, 50);


        // --- 2. CROSS-SELL COM IDs DE VARIANTE ---
        if (window.renderZaleskiProductCrossSell) {
            var crossProps = { main: null, related: null };
            {% set cross_sell_product = null %}
            {% if complementary_product_list | length > 0 %}
                {% for p in complementary_product_list %}
                    {% if p.available and not cross_sell_product %}
                        {% set cross_sell_product = p %}
                    {% endif %}
                {% endfor %}
            {% endif %}

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
                        variantId: {{ cross_sell_product.variants[0].id }},
                        name: "{{ cross_sell_product.name | escape('js') }}",
                        price: {{ cross_sell_product.price / 100 }},
                        priceFormatted: "{{ cross_sell_product.price | money | escape('js') }}",
                        imgUrl: "{{ cross_sell_product.featured_image | product_image_url('medium') | escape('js') }}",
                        variationsList: [
                            {% for variation in cross_sell_product.variations %}
                                {
                                    id: "{{ variation.id }}",
                                    name: "{{ variation.name | escape('js') }}",
                                    options: [
                                        {% for option in variation.options %}
                                            { id: "{{ option.id }}", name: "{{ option.name | escape('js') }}" }{% if not loop.last %},{% endif %}
                                        {% endfor %}
                                    ]
                                }{% if not loop.last %},{% endif %}
                            {% endfor %}
                        ],
                        variantsMap: [
                            {% for variant in cross_sell_product.variants %}
                                {
                                    id: {{ variant.id }},
                                    available: {% if variant.available %}true{% else %}false{% endif %},
                                    options: [
                                        {% if variant.option0 %}"{{ variant.option0 | escape('js') }}"{% endif %}
                                        {% if variant.option1 %}, "{{ variant.option1 | escape('js') }}"{% endif %}
                                        {% if variant.option2 %}, "{{ variant.option2 | escape('js') }}"{% endif %}
                                    ]
                                }{% if not loop.last %},{% endif %}
                            {% endfor %}
                        ],
                        options: [
                            {% if cross_sell_product.variants[0].option0 %}"{{ cross_sell_product.variants[0].option0 | escape('js') }}",{% endif %}
                            {% if cross_sell_product.variants[0].option1 %}"{{ cross_sell_product.variants[0].option1 | escape('js') }}",{% endif %}
                            {% if cross_sell_product.variants[0].option2 %}"{{ cross_sell_product.variants[0].option2 | escape('js') }}"{% endif %}
                        ].filter(Boolean)
                    }
                };
            {% else %}
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

        // 7. PERSONALIZATION MODAL
        var chkModal = setInterval(function() {
            if (window.renderZaleskiPersonalizationModal && document.getElementById('react-zaleski-pdp-personalization-modal')) {
                clearInterval(chkModal);
                var modalProps = {
                    instagramUrl: "{{ settings.pdp_personalization_link | default(store.instagram) | escape('js') }}",
                    contentHtml: "{{ settings.pdp_personalization_content | default('<p>Cada peça pode ser ajustada para ficar perfeita em você.</p>') | escape('js') }}"
                };
                window.renderZaleskiPersonalizationModal('react-zaleski-pdp-personalization-modal', modalProps);
            }
        }, 50);

        // 8. VIDEOS
        var chkVideo = setInterval(function() {
            if (window.renderZaleskiProductVideos && document.getElementById('react-zaleski-pdp-videos')) {
                clearInterval(chkVideo);
                var videoList = [];

                {% if product.video_url %}
                    videoList.push({ videoUrl: "{{ product.video_url | escape('js') }}" });
                {% endif %}

                {% for tag in product.tags %}
                    {% set lower_tag = tag | lower %}
                    {% if lower_tag | slice(0, 6) == 'video:' %}
                        videoList.push({ videoUrl: "{{ tag | slice(6) | trim | escape('js') }}" });
                    {% endif %}
                {% endfor %}

                if (videoList.length > 0) {
                    var videoProps = {
                        title: "{{ settings.pdp_video_title | default('Veja no Corpo') | escape('js') }}",
                        videos: videoList
                    };
                    window.renderZaleskiProductVideos('react-zaleski-pdp-videos', videoProps);
                }
            }
        }, 50);

        // 9. CAROUSELS
        var chkShelves = setInterval(function() {
            if (window.renderZaleskiCarousel && document.getElementById('react-zaleski-pdp-related-shelf')) {
                clearInterval(chkShelves);

                var currentProductId = parseInt(window.ZALESKI_PRODUCT_ID);
                var usedIds = [currentProductId];
                
                var rawComplementary = [];
                {% if complementary_product_list %}
                    {% for p in complementary_product_list | take(4) %}
                        rawComplementary.push({
                            id: {{ p.id }},
                            name: "{{ p.name | escape('js') }}",
                            price: "{{ p.price | money | escape('js') }}",
                            comparePrice: {% if p.compare_at_price > p.price %}"{{ p.compare_at_price | money | escape('js') }}"{% else %}null{% endif %},
                            imgUrl: "{{ p.featured_image | product_image_url('medium') | escape('js') }}",
                            url: "{{ p.url | escape('js') }}"
                        });
                    {% endfor %}
                {% endif %}

                var rawRelated = [];
                {% if product.related_products %}
                    {% for p in product.related_products | take(10) %}
                        rawRelated.push({
                            id: {{ p.id }},
                            name: "{{ p.name | escape('js') }}",
                            price: "{{ p.price | money | escape('js') }}",
                            comparePrice: {% if p.compare_at_price > p.price %}"{{ p.compare_at_price | money | escape('js') }}"{% else %}null{% endif %},
                            imgUrl: "{{ p.featured_image | product_image_url('medium') | escape('js') }}",
                            url: "{{ p.url | escape('js') }}"
                        });
                    {% endfor %}
                {% endif %}

                var rawCategory = [];
                {% if product.category.products %}
                    {% for p in product.category.products | take(40) %}
                        rawCategory.push({
                            id: {{ p.id }},
                            name: "{{ p.name | escape('js') }}",
                            price: "{{ p.price | money | escape('js') }}",
                            comparePrice: {% if p.compare_at_price > p.price %}"{{ p.compare_at_price | money | escape('js') }}"{% else %}null{% endif %},
                            imgUrl: "{{ p.featured_image | product_image_url('medium') | escape('js') }}",
                            url: "{{ p.url | escape('js') }}"
                        });
                    {% endfor %}
                {% endif %}

                var shuffledCat = rawCategory.slice().sort(function() { return 0.5 - Math.random() });

                var relatedList = [];
                
                for (var i = 0; i < rawComplementary.length; i++) {
                    if (relatedList.length < 4 && usedIds.indexOf(rawComplementary[i].id) === -1) {
                        relatedList.push(rawComplementary[i]);
                        usedIds.push(rawComplementary[i].id);
                    }
                }
                
                for (var j = 0; j < shuffledCat.length; j++) {
                    if (relatedList.length < 4 && usedIds.indexOf(shuffledCat[j].id) === -1) {
                        relatedList.push(shuffledCat[j]);
                        usedIds.push(shuffledCat[j].id);
                    }
                }

                var colorList = [];
                
                for (var k = 0; k < rawRelated.length; k++) {
                    if (colorList.length < 4 && usedIds.indexOf(rawRelated[k].id) === -1) {
                        colorList.push(rawRelated[k]);
                        usedIds.push(rawRelated[k].id);
                    }
                }
                
                for (var m = 0; m < shuffledCat.length; m++) {
                    if (colorList.length < 4 && usedIds.indexOf(shuffledCat[m].id) === -1) {
                        colorList.push(shuffledCat[m]);
                        usedIds.push(shuffledCat[m].id);
                    }
                }

                if (relatedList.length > 0) {
                    window.renderZaleskiCarousel('react-zaleski-pdp-related-shelf', {
                        title: "Get the look",
                        items: relatedList
                    });
                }

                if (colorList.length > 0 && document.getElementById('react-zaleski-pdp-color-shelf')) {
                    window.renderZaleskiCarousel('react-zaleski-pdp-color-shelf', {
                        title: "Mais nesta cor",
                        items: colorList
                    });
                }
            }
        }, 50);

        // 10. DRAMERS
        var chkDramers = setInterval(function() {
            if (window.renderZaleskiDreamers && document.getElementById('react-zaleski-pdp-dramers')) {
                clearInterval(chkDramers);
                var dreamersList = [];
                var configuredDreamers = [
                    { image: "{{ 'dreamers_1_image.jpg' | static_url | escape('js') }}", username: "{{ settings.dreamers_1_username | escape('js') }}", url: "{{ settings.dreamers_1_url | escape('js') }}", hasImage: {{ 'dreamers_1_image.jpg' | has_custom_image ? 'true' : 'false' }} },
                    { image: "{{ 'dreamers_2_image.jpg' | static_url | escape('js') }}", username: "{{ settings.dreamers_2_username | escape('js') }}", url: "{{ settings.dreamers_2_url | escape('js') }}", hasImage: {{ 'dreamers_2_image.jpg' | has_custom_image ? 'true' : 'false' }} },
                    { image: "{{ 'dreamers_3_image.jpg' | static_url | escape('js') }}", username: "{{ settings.dreamers_3_username | escape('js') }}", url: "{{ settings.dreamers_3_url | escape('js') }}", hasImage: {{ 'dreamers_3_image.jpg' | has_custom_image ? 'true' : 'false' }} },
                    { image: "{{ 'dreamers_4_image.jpg' | static_url | escape('js') }}", username: "{{ settings.dreamers_4_username | escape('js') }}", url: "{{ settings.dreamers_4_url | escape('js') }}", hasImage: {{ 'dreamers_4_image.jpg' | has_custom_image ? 'true' : 'false' }} },
                    { image: "{{ 'dreamers_5_image.jpg' | static_url | escape('js') }}", username: "{{ settings.dreamers_5_username | escape('js') }}", url: "{{ settings.dreamers_5_url | escape('js') }}", hasImage: {{ 'dreamers_5_image.jpg' | has_custom_image ? 'true' : 'false' }} },
                    { image: "{{ 'dreamers_6_image.jpg' | static_url | escape('js') }}", username: "{{ settings.dreamers_6_username | escape('js') }}", url: "{{ settings.dreamers_6_url | escape('js') }}", hasImage: {{ 'dreamers_6_image.jpg' | has_custom_image ? 'true' : 'false' }} }
                ];
                for (var i = 0; i < configuredDreamers.length; i++) {
                    if (configuredDreamers[i].hasImage && configuredDreamers[i].username) {
                        dreamersList.push(configuredDreamers[i]);
                    }
                }
                window.renderZaleskiDreamers('react-zaleski-pdp-dramers', {
                    title: "{{ settings.dreamers_title | default('Dreamers') | escape('js') }}",
                    subtitle: "{{ settings.dreamers_subtitle | default('Nossas clientes usando Zaleski no dia a dia') | escape('js') }}",
                    footerText: "{{ settings.dreamers_footer | default('Poste com #ZaleskiDream para aparecer aqui') | escape('js') }}",
                    items: dreamersList
                });
            }
        }, 50);

        // 11. REVIEWS
        var chkReviews = setInterval(function() {
            if (window.renderZaleskiTestimonials && document.getElementById('react-zaleski-pdp-reviews')) {
                clearInterval(chkReviews);
                var rList = [];
                var cReviews = [
                    { image: "{{ 'review_1_image.jpg' | static_url | settings_image_url('large') | escape('js') }}", name: "{{ settings.review_1_name | escape('js') }}", text: "{{ settings.review_1_text | escape('js') }}", hasImage: {{ 'review_1_image.jpg' | has_custom_image ? 'true' : 'false' }} },
                    { image: "{{ 'review_2_image.jpg' | static_url | settings_image_url('large') | escape('js') }}", name: "{{ settings.review_2_name | escape('js') }}", text: "{{ settings.review_2_text | escape('js') }}", hasImage: {{ 'review_2_image.jpg' | has_custom_image ? 'true' : 'false' }} },
                    { image: "{{ 'review_3_image.jpg' | static_url | settings_image_url('large') | escape('js') }}", name: "{{ settings.review_3_name | escape('js') }}", text: "{{ settings.review_3_text | escape('js') }}", hasImage: {{ 'review_3_image.jpg' | has_custom_image ? 'true' : 'false' }} }
                ];
                for (var i = 0; i < cReviews.length; i++) {
                    if (cReviews[i].name && cReviews[i].text) {
                        if (!cReviews[i].hasImage) delete cReviews[i].image;
                        rList.push(cReviews[i]);
                    }
                }
                window.renderZaleskiTestimonials('react-zaleski-pdp-reviews', {
                    productId: {{ product.id }},
                    title: "{{ settings.reviews_title | default('O que dizem sobre nós') | escape('js') }}",
                    items: rList
                });
            }
        }, 50);

        // 12. ONDEMAND
        var chkDemand = setInterval(function() {
            if (window.renderZaleskiAbout && document.getElementById('react-zaleski-pdp-ondemand')) {
                clearInterval(chkDemand);
                window.renderZaleskiAbout('react-zaleski-pdp-ondemand', {
                    title: "{{ settings.about_title | default('Feito sob demanda em Porto Alegre.') | escape('js') }}",
                    description: "{{ settings.about_description | default('') | escape('js') }}",
                    linkText: "{{ settings.about_link_text | default('Conheça nossa história →') | escape('js') }}",
                    linkUrl: "{{ settings.about_link_url | default('#') | escape('js') }}",
                    stampTop: "{{ settings.about_stamp_top | default('Feito em Porto Alegre') | escape('js') }}",
                    stampBottom: "{{ settings.about_stamp_bottom | default('desde 2020') | escape('js') }}"
                });
            }
        }, 50);

        if (window.renderZaleskiToast) {
            window.renderZaleskiToast('react-zaleski-toast');
        }
    }

    if (document.readyState !== 'loading') initPDP();
    else document.addEventListener('DOMContentLoaded', initPDP);
})();
</script>

<div style="position: absolute; left: -9999px; width: 1px; height: 1px; overflow: hidden;" aria-hidden="true" class="zaleski-hidden-shipping-engine">
    <div id="product-shipping-container" class="product-shipping-calculator list w-100" data-shipping-url="{{ store.shipping_calculator_url }}">
        {% if store.has_shipping %}
            {% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
        {% endif %}
    </div>
</div>

<div id="react-zaleski-pdp-videos"></div>
<div id="react-zaleski-pdp-personalization-modal"></div>
<div id="react-zaleski-pdp-related-shelf"></div>
<div id="react-zaleski-pdp-color-shelf"></div>
<div id="react-zaleski-pdp-dramers"></div>
<div id="react-zaleski-pdp-reviews"></div>
<div id="react-zaleski-pdp-ondemand"></div>
<div id="react-zaleski-toast"></div>

