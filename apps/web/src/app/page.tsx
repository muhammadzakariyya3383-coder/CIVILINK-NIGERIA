const modules = [
  { title: "Jobs & Employment", description: "Discover opportunities and connect with employers." },
  { title: "Business Directory", description: "Find businesses and organisations across Nigeria." },
  { title: "Services Finder", description: "Discover skilled professionals and local services." },
  { title: "Marketplace", description: "Explore products from participating Nigerian sellers." },
  { title: "Education & Scholarships", description: "Find learning, training and scholarship opportunities." }
];

export default function HomePage() {
  return (
    <main className="page-shell">
      <header className="topbar">
        <a className="brand" href="/" aria-label="CIVILINK NIGERIA home">CIVILINK <span>NIGERIA</span></a>
        <span className="pilot-label">Building for all 36 states + FCT</span>
      </header>

      <section className="hero">
        <p className="eyebrow">A connected Nigeria starts here</p>
        <h1>One Platform. Every Nigerian. Endless Opportunities.</h1>
        <p className="hero-copy">
          A digital platform designed to help people discover jobs, businesses,
          services, products and education opportunities across Nigeria.
        </p>
        <p className="status-note">Development preview · Sokoto pilot planned</p>
      </section>

      <section className="module-section" aria-labelledby="modules-title">
        <div className="section-heading">
          <p className="eyebrow">The first release</p>
          <h2 id="modules-title">Opportunities in one place</h2>
        </div>
        <div className="module-grid">
          {modules.map((module) => (
            <article className="module-card" key={module.title}>
              <h3>{module.title}</h3>
              <p>{module.description}</p>
              <span className="coming-soon">Planned module</span>
            </article>
          ))}
        </div>
      </section>

      <footer className="footer">
        <strong>CIVILINK NIGERIA</strong>
        <span>Early development foundation. Not yet open for public registration.</span>
      </footer>
    </main>
  );
}
