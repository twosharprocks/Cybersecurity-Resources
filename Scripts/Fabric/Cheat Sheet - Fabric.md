Tags: [[Cyber]] [[AI]]

---
[GitHub Page](https://github.com/danielmiessler/fabric) 
# Basics
Using Fabric: `input | fabric options -sp pattern_name |save "File Name"`
Options
- -s (Stream output), 
- -p / --pattern (Pattern to choose)
- -c / --context (context file use)
- -l / --list (List available patterns)
- --listmodels, --model, --changedefaultmodel
-  --remoteollamaserver (IP of local AI server to use)

Modify API keys and save folder: `nano ~/.config/fabric/.env
Update: `fabric -u / --update (Reverts default to gpt-4o)`

Other Inputs
- Youtube: `yt [-h] [--duration] [--transcript] [url]`
- Transcribe Audio: `ts PathToAudioFile`
- PDF to Text (https://pypi.org/project/pdftotext/)
	- `pdftotext filepath/filename.pdf text.txt` Generate text file
	- `pdftotext filepath/filename.pdf - ` To output directly to terminal
- pbcopy & pbpaste
	- `apt install xsel
	- Add aliases with `nano ~/.bashrc
		- `alias pbcopy='xsel --input --clipboard'
		- `alias pbpaste='xsel --output --clipboard'
	-  Save and refresh .bashrc with `source ~/.bashrc`

Custom Patterns
- Create folder in ~/.config/fabric/custom-fabric-patterns/ with pattern name
- Create system.md and copy prompt into it
- Copy custom files to Fabric: cp -a ~/.config/custom-fabric-patterns/* ~/.config/fabric/patterns/
	Also |[improve_prompt](https://github.com/danielmiessler/fabric/tree/main/patterns/improve_prompt "improve_prompt"), |[create_pattern](https://github.com/danielmiessler/fabric/tree/main/patterns/create_pattern "create_pattern")| & |[official_pattern_template](https://github.com/danielmiessler/fabric/tree/main/patterns/official_pattern_template "official_pattern_template")

---
## Cybersecurity
- News
	- |[analyze_incident](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_incident "analyze_incident")| Summarize news article on cyber incident
	- |[create_security_update](https://github.com/danielmiessler/fabric/tree/main/patterns/create_security_update "create_security_update")| Summarise cybersecurity newsletter
- Reports
	- |[analyze_logs](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_logs "analyze_logs")| Ingests log, analyzes for patterns/issues/anomalies, makes recommendations
	- |[analyze_malware](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_malware "analyze_malware")| Find IOCs, Behaviour, Mitre ATT&CK
	- |[analyze_threat_report](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_threat_report "analyze_threat_report")| Analyze/Summarize cybersecurity threat reports, 
		- Also |[analyze_threat_report_trends](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_threat_report_trends "analyze_threat_report_trends")| 
	- |[create_threat_scenarios](https://github.com/danielmiessler/fabric/tree/main/patterns/create_threat_scenarios "create_threat_scenarios")| Threat model likely ways a system may be attacked
	- |[create_report_finding](https://github.com/danielmiessler/fabric/tree/main/patterns/create_report_finding "create_report_finding")| Generate security findings for assessment report
	- |[create_network_threat_landscape](https://github.com/danielmiessler/fabric/tree/main/patterns/create_network_threat_landscape "create_network_threat_landscape")| Analyse open ports and services from list
	- |[create_stride_threat_model](https://github.com/danielmiessler/fabric/tree/main/patterns/create_stride_threat_model "create_stride_threat_model")| Analyse design document using STRIDE threat modelling
	- |[create_cyber_summary](https://github.com/danielmiessler/fabric/tree/main/patterns/create_cyber_summary "create_cyber_summary")| Summarize cyber document for non-cyber people
- Other
	- |[ask_secure_by_design_questions](https://github.com/danielmiessler/fabric/tree/main/patterns/ask_secure_by_design_questions "ask_secure_by_design_questions")| Analyze anything for secure by design
	- |[create_command](https://github.com/danielmiessler/fabric/tree/main/patterns/create_command "create_command")| Generate command with options for a specific tool (eg NMap)
	- |[create_ai_jobs_analysis](https://github.com/danielmiessler/fabric/tree/main/patterns/create_ai_jobs_analysis "create_ai_jobs_analysis")| Input job reports, generate jobs safer to automation + recommendations
## Writing - Analyze
- Quality
	- |[analyze_prose](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_prose "analyze_prose")| Writing quality, content novelty, Also- |[analyze_prose_json](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_prose_json "analyze_prose_json")|
	- |[analyze_prose_pinker](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_prose_pinker "analyze_prose_pinker")| Steven Pinker "Sense of Style"
	- |[rate_content](https://github.com/danielmiessler/fabric/tree/main/patterns/rate_content "rate_content")| |[rate_value](https://github.com/danielmiessler/fabric/tree/main/patterns/rate_value "rate_value")|
	- |[analyze_presentation](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_presentation "analyze_presentation")| Analyse & critique a presentation, including main points & underlying psychology of speaker, Also |[analyze_personality](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_personality "analyze_personality")|
	- |[analyze_debate](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_debate "analyze_debate") | Generate objective perspective on a debate, analyze emotionality/claims/arguments/misunderstandings & provide learnings
	- |[find_hidden_message](https://github.com/danielmiessler/fabric/tree/main/patterns/find_hidden_message "find_hidden_message")| Also |[find_logical_fallacies](https://github.com/danielmiessler/fabric/tree/main/patterns/find_logical_fallacies "find_logical_fallacies")|
- Content
	- |[rate_ai_response](https://github.com/danielmiessler/fabric/tree/main/patterns/rate_ai_response "rate_ai_response")| |[rate_ai_result](https://github.com/danielmiessler/fabric/tree/main/patterns/rate_ai_result "rate_ai_result")|
	- |[analyze_claims](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_claims "analyze_claims") | Analyze argument, provide evidence for claim & counter-claims
	- |[analyze_paper](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_paper "analyze_paper")| Primary findings of scientific paper & rigor/quality (also |[summarize_paper](https://github.com/danielmiessler/fabric/tree/main/patterns/summarize_paper "summarize_paper")|)
	- |[check_agreement](https://github.com/danielmiessler/fabric/tree/main/patterns/check_agreement "check_agreement")| Analyse contracts & agreements
	- |[analyze_patent](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_patent "analyze_patent")| Analyse patent documents
	- |[analyze_tech_impact](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_tech_impact "analyze_tech_impact")| Analyse societal impact of tech project
- Summarize
	- |[create_summary](https://github.com/danielmiessler/fabric/tree/main/patterns/create_summary "create_summary")| same as |[summarize](https://github.com/danielmiessler/fabric/tree/main/patterns/summarize "summarize")| 
	- |[create_micro_summary](https://github.com/danielmiessler/fabric/tree/main/patterns/create_micro_summary "create_micro_summary")| same as |[summarize_micro](https://github.com/danielmiessler/fabric/tree/main/patterns/summarize_micro "summarize_micro")|
	- |[create_5_sentence_summary](https://github.com/danielmiessler/fabric/tree/main/patterns/create_5_sentence_summary "create_5_sentence_summary")| Summary with 5 lines (WC = 5, 4, 3, 2, 1)
	- |[summarize_debate](https://github.com/danielmiessler/fabric/tree/main/patterns/summarize_debate "summarize_debate")| 
	- |[summarize_newsletter](https://github.com/danielmiessler/fabric/tree/main/patterns/summarize_newsletter "summarize_newsletter")|
	- |[capture_thinkers_work](https://github.com/danielmiessler/fabric/tree/main/patterns/capture_thinkers_work "capture_thinkers_work")| Summarize a well known person's work
## Writing - Generate
- |[clean_text](https://github.com/danielmiessler/fabric/tree/main/patterns/clean_text "clean_text")| Cleaning up broken & malformed text
- |[improve_writing](https://github.com/danielmiessler/fabric/tree/main/patterns/improve_writing "improve_writing")| Also |[improve_academic_writing](https://github.com/danielmiessler/fabric/tree/main/patterns/improve_academic_writing "improve_academic_writing")|
- |[create_academic_paper](https://github.com/danielmiessler/fabric/tree/main/patterns/create_academic_paper "create_academic_paper")| 
- |[write_essay](https://github.com/danielmiessler/fabric/tree/main/patterns/write_essay "write_essay")| &  |[write_micro_essay](https://github.com/danielmiessler/fabric/tree/main/patterns/write_micro_essay "write_micro_essay")|
- |[create_keynote](https://github.com/danielmiessler/fabric/tree/main/patterns/create_keynote "create_keynote")| Create a TED-Talk
- |[answer_interview_question](https://github.com/danielmiessler/fabric/tree/main/patterns/answer_interview_question "answer_interview_question")| Generate answers for interview questions
- |[create_quiz](https://github.com/danielmiessler/fabric/tree/main/patterns/create_quiz "create_quiz")| Generate quiz to concepts of a learning objectives provided. 
	- Counterpart |[analyze_answers](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_answers "analyze_answers")|
- |[create_aphorisms](https://github.com/danielmiessler/fabric/tree/main/patterns/create_aphorisms "create_aphorisms")| Pull quotes related to a topic
- |[compare_and_contrast](https://github.com/danielmiessler/fabric/tree/main/patterns/compare_and_contrast "compare_and_contrast")| Compare a list of items & generate a Markdown table
- |[to_flashcards](https://github.com/danielmiessler/fabric/tree/main/patterns/to_flashcards "to_flashcards")| Create Anki flashcards for memorisation
## Philosophy
- |[analyze_spiritual_text](https://github.com/danielmiessler/fabric/tree/main/patterns/analyze_spiritual_text "analyze_spiritual_text")| Claims made and comparison to King James Bible
- |[create_reading_plan](https://github.com/danielmiessler/fabric/tree/main/patterns/create_reading_plan "create_reading_plan")| Develop reading suggestions based on user interests
- |[create_upgrade_pack](https://github.com/danielmiessler/fabric/tree/main/patterns/create_upgrade_pack "create_upgrade_pack")| Reflecting on world view and how to approach tasks with that world view (Use for intelligence - getting into perspective of another)
- |[create_better_frame](https://github.com/danielmiessler/fabric/tree/main/patterns/create_better_frame "create_better_frame")| Find better, positive mental frames from content
## Coding
- |[coding_master](https://github.com/danielmiessler/fabric/tree/main/patterns/coding_master "coding_master")| Understanding core coding concepts & different languages
- Git: |[create_git_diff_commit](https://github.com/danielmiessler/fabric/tree/main/patterns/create_git_diff_commit "create_git_diff_commit")| |[summarize_git_changes](https://github.com/danielmiessler/fabric/tree/main/patterns/summarize_git_changes "summarize_git_changes")| |[summarize_git_diff](https://github.com/danielmiessler/fabric/tree/main/patterns/summarize_git_diff "summarize_git_diff")| 
- |[write_pull-request](https://github.com/danielmiessler/fabric/tree/main/patterns/write_pull-request "write_pull-request")| Pull request description from Git Diff, also |[summarize_pull-requests](https://github.com/danielmiessler/fabric/tree/main/patterns/summarize_pull-requests "summarize_pull-requests")|
- |[agility_story](https://github.com/danielmiessler/fabric/blob/main/patterns/agility_story/system.md)| Generate an Agile user story in JSON
- |[create_coding_project](https://github.com/danielmiessler/fabric/tree/main/patterns/create_coding_project "create_coding_project")|

---
## Create
- |[create_art_prompt](https://github.com/danielmiessler/fabric/tree/main/patterns/create_art_prompt "create_art_prompt")|
- |[create_idea_compass](https://github.com/danielmiessler/fabric/tree/main/patterns/create_idea_compass "create_idea_compass")|
- |[create_investigation_visualization](https://github.com/danielmiessler/fabric/tree/main/patterns/create_investigation_visualization "create_investigation_visualization")|
- |[create_logo](https://github.com/danielmiessler/fabric/tree/main/patterns/create_logo "create_logo")|
- |[create_markmap_visualization](https://github.com/danielmiessler/fabric/tree/main/patterns/create_markmap_visualization "create_markmap_visualization")|
- |[create_mermaid_visualization](https://github.com/danielmiessler/fabric/tree/main/patterns/create_mermaid_visualization "create_mermaid_visualization")|
- |[create_show_intro](https://github.com/danielmiessler/fabric/tree/main/patterns/create_show_intro "create_show_intro")|
- |[create_video_chapters](https://github.com/danielmiessler/fabric/tree/main/patterns/create_video_chapters "create_video_chapters")|
- |[create_visualization](https://github.com/danielmiessler/fabric/tree/main/patterns/create_visualization "create_visualization")|
## Explain
|[explain_code](https://github.com/danielmiessler/fabric/tree/main/patterns/explain_code "explain_code")|
|[explain_docs](https://github.com/danielmiessler/fabric/tree/main/patterns/explain_docs "explain_docs")|
|[explain_project](https://github.com/danielmiessler/fabric/tree/main/patterns/explain_project "explain_project")|
|[explain_terms](https://github.com/danielmiessler/fabric/tree/main/patterns/explain_terms "explain_terms")|
|[extract_algorithm_update_recommendations](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_algorithm_update_recommendations "extract_algorithm_update_recommendations")|
|[extract_article_wisdom](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_article_wisdom "extract_article_wisdom")|
|[extract_book_ideas](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_book_ideas "extract_book_ideas")|
|[extract_book_recommendations](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_book_recommendations "extract_book_recommendations")|
|[extract_business_ideas](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_business_ideas "extract_business_ideas")|
|[extract_extraordinary_claims](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_extraordinary_claims "extract_extraordinary_claims")|
|[extract_ideas](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_ideas "extract_ideas")|
|[extract_insights](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_insights "extract_insights")|
|[extract_main_idea](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_main_idea "extract_main_idea")|
|[extract_patterns](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_patterns "extract_patterns")|
|[extract_poc](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_poc "extract_poc")|
|[extract_predictions](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_predictions "extract_predictions")|
|[extract_questions](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_questions "extract_questions")|
|[extract_recommendations](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_recommendations "extract_recommendations")|
|[extract_references](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_references "extract_references")|
|[extract_song_meaning](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_song_meaning "extract_song_meaning")|
|[extract_sponsors](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_sponsors "extract_sponsors")|
|[extract_videoid](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_videoid "extract_videoid")|
|[extract_wisdom](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_wisdom "extract_wisdom")|
|[extract_wisdom_agents](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_wisdom_agents "extract_wisdom_agents")|
|[extract_wisdom_dm](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_wisdom_dm "extract_wisdom_dm")|
|[extract_wisdom_nometa](https://github.com/danielmiessler/fabric/tree/main/patterns/extract_wisdom_nometa "extract_wisdom_nometa")|
|[get_wow_per_minute](https://github.com/danielmiessler/fabric/tree/main/patterns/get_wow_per_minute "get_wow_per_minute")|
|[get_youtube_rss](https://github.com/danielmiessler/fabric/tree/main/patterns/get_youtube_rss "get_youtube_rss")|
|[improve_report_finding](https://github.com/danielmiessler/fabric/tree/main/patterns/improve_report_finding "improve_report_finding")|
|[label_and_rate](https://github.com/danielmiessler/fabric/tree/main/patterns/label_and_rate "label_and_rate")|
|[provide_guidance](https://github.com/danielmiessler/fabric/tree/main/patterns/provide_guidance "provide_guidance")|
|[raw_query](https://github.com/danielmiessler/fabric/tree/main/patterns/raw_query "raw_query")|
|[recommend_artists](https://github.com/danielmiessler/fabric/tree/main/patterns/recommend_artists "recommend_artists")|
|[write_nuclei_template_rule](https://github.com/danielmiessler/fabric/tree/main/patterns/write_nuclei_template_rule "write_nuclei_template_rule")|
|[write_semgrep_rule](https://github.com/danielmiessler/fabric/tree/main/patterns/write_semgrep_rule "write_semgrep_rule")|