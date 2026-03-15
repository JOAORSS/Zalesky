<section class="section-testimonials">
    <div id="react-testimonial-section"></div>
</section>

<script>
window.addEventListener('load', function() {
    if (window.renderZaleskiTestimonials) {
        var reviewsList = [];
        
        var configuredReviews = [
            {
                image: "{{ 'review_1_image.jpg' | static_url | settings_image_url('large') }}",
                name: "{{ settings.review_1_name | escape('js') }}",
                text: "{{ settings.review_1_text | escape('js') }}",
                hasImage: {{ 'review_1_image.jpg' | has_custom_image ? 'true' : 'false' }}
            },
            {
                image: "{{ 'review_2_image.jpg' | static_url | settings_image_url('large') }}",
                name: "{{ settings.review_2_name | escape('js') }}",
                text: "{{ settings.review_2_text | escape('js') }}",
                hasImage: {{ 'review_2_image.jpg' | has_custom_image ? 'true' : 'false' }}
            },
            {
                image: "{{ 'review_3_image.jpg' | static_url | settings_image_url('large') }}",
                name: "{{ settings.review_3_name | escape('js') }}",
                text: "{{ settings.review_3_text | escape('js') }}",
                hasImage: {{ 'review_3_image.jpg' | has_custom_image ? 'true' : 'false' }}
            }
        ];

        for (var i = 0; i < configuredReviews.length; i++) {
            if (configuredReviews[i].name && configuredReviews[i].text) {
                if (!configuredReviews[i].hasImage) {
                    delete configuredReviews[i].image;
                }
                delete configuredReviews[i].hasImage;
                reviewsList.push(configuredReviews[i]);
            }
        }

        if (reviewsList.length > 0) {
            var props = {
                title: "{{ settings.reviews_title | default('O que dizem sobre nós') | escape('js') }}",
                items: reviewsList
            };

            window.renderZaleskiTestimonials('react-testimonial-section', props);
        }
    }
});
</script>
