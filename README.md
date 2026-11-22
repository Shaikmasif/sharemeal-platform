\# ShareMeal Platform



\*\*ShareMeal\*\* is a B2B zero-waste food rescue platform that connects restaurants with verified NGOs to redistribute surplus meals before they expire. Built with a Spring Boot microservices architecture, it focuses on strict domain boundaries, geospatial matching, fault tolerance, and automated compliance reporting.



\## Architecture Overview



ShareMeal follows the \*\*Database-per-Service\*\* pattern using MySQL 8.0, fronted by a Spring Cloud API Gateway and discovered via Netflix Eureka.



| Service | Database | Core Responsibility |

| :--- | :--- | :--- |

| \*\*RegistrationService\*\* | `db\_registration` | Identity management, JWT/RBAC authentication, admin NGO verification, and geospatial coordinate storage (`POINT`). |

| \*\*SurplusService\*\* | `db\_surplus` | Food inventory state machine (`AVAILABLE`, `CLAIMED`, `COMPLETED`, `EXPIRED`), optimistic locking (`@Version`), and `@Scheduled` expiration/no-show timers. |

| \*\*DispatcherService\*\* | `db\_dispatcher` | Spatial radius matching (`ST\_Distance\_Sphere`), time-bound NGO alerts, and Resilience4j circuit-broken SMS/Email fallbacks. |

| \*\*ReceiptService\*\* | `db\_receipt` | Blind 4-digit OTP handoff verification, `@Async` HTML-to-PDF tax receipt generation, streaming Excel reports, and legacy SOAP tax sync with retry queuing. |



\## Key Technical Features



\* \*\*Geospatial Matching:\*\* Native MySQL `POINT` indexing and `ST\_Distance\_Sphere` queries to locate approved NGOs within a 5km radius in milliseconds.

\* \*\*Concurrency \& State Control:\*\* JPA Optimistic Locking prevents race conditions when multiple NGOs attempt to claim the same listing simultaneously.

\* \*\*Resilience \& Fault Tolerance:\*\* Resilience4j Circuit Breakers protect external SMS and SOAP APIs with automatic fallbacks (Email alerts and `pending\_tax\_sync` retry queues).

\* \*\*Secure Physical Handoff:\*\* Blind BCrypt-hashed 4-digit OTP verification between the NGO driver and restaurant manager.

\* \*\*Enterprise Reporting:\*\* Thymeleaf + OpenHTMLToPDF for downloadable "Served for Humanity" PDF receipts, and Apache POI (`SXSSFWorkbook`) for memory-safe filtered Excel exports.



\## Tech Stack



\* \*\*Backend:\*\* Java 17+, Spring Boot 3.x, Spring Cloud (Gateway, Eureka, OpenFeign), Spring Security (JWT), Spring Data JPA, Resilience4j

\* \*\*Database:\*\* MySQL 8.0 (Spatial Extensions)

\* \*\*Reporting \& Messaging:\*\* Thymeleaf, OpenHTMLToPDF, Apache POI, JavaMailSender

\* \*\*Frontend:\*\* React, Tailwind CSS, React-Leaflet, Axios

\* \*\*DevOps \& Tooling:\*\* Maven, Git (Monorepo), Docker, Jenkins, Postman



\## Repository Structure



```text

sharemeal-platform/

├── infrastructure/          # Database init scripts \& Docker configurations

├── platform-routing/        # Eureka Server \& API Gateway

├── core-services/           # Registration, Surplus, Dispatcher, and Receipt microservices

├── web-frontend/            # React + Tailwind CSS dashboard

├── Jenkinsfile              # CI/CD pipeline definition

└── .gitignore


\## More Features to be added...

