private func setupLayout() {
    addSubview(scrollView)
    addSubview(buttonsStackView)
    
    scrollView.addSubview(contentStackView)
    buttonsStackView.addArrangedSubview(skipButton)
    buttonsStackView.addArrangedSubview(nextButton)
}

private func setupConstraints() {
    NSLayoutConstraint.activate([
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        scrollView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -20),
        
        contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        contentStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: CGFloat(OnboardingPage.count)),

        buttonsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
        buttonsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        buttonsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
        buttonsStackView.heightAnchor.constraint(equalToConstant: 64)
    ])

    let skipButtonWidth = skipButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.40)
    skipButtonWidth.priority = .defaultHigh
    skipButtonWidth.isActive = true
    
    let nextButtonWidth = nextButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.55)
    nextButtonWidth.priority = .defaultHigh
    nextButtonWidth.isActive = true
}

func configure(with page: Int) {
    for (_, pageView) in pageViews.enumerated() {
        pageView.updateCurrentPage(page)
    }
    
    nextButton.setTitle(OnboardingPage.isLastPage(page) ? "Continue" : "Next")
    
    let contentOffset = CGPoint(x: scrollView.bounds.width * CGFloat(page), y: 0)
    scrollView.setContentOffset(contentOffset, animated: true)
} 