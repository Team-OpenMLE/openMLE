CREATE TABLE `messages` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`session_id` integer NOT NULL,
	`request` text NOT NULL,
	`response` text,
	`created_at` integer,
	`updated_at` integer,
	FOREIGN KEY (`session_id`) REFERENCES `chat-sessions`(`id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
CREATE TABLE `chat-sessions` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`created_at` integer,
	`updated_at` integer
);
--> statement-breakpoint
CREATE TABLE `connections` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`connector` text NOT NULL,
	`type` text NOT NULL,
	`creds` text,
	`isdefault` integer,
	`created_at` integer,
	`updated_at` integer,
	`isValid` integer
);
--> statement-breakpoint
CREATE INDEX `connections_connector` ON `connections` (`connector`);--> statement-breakpoint
CREATE INDEX `idx_connections_default` ON `connections` (`isdefault`);--> statement-breakpoint
CREATE INDEX `idx_connections_valid` ON `connections` (`isValid`);--> statement-breakpoint
CREATE TABLE `llmconnections` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`provider` text NOT NULL,
	`key` text NOT NULL,
	`model` text NOT NULL,
	`is_default` integer DEFAULT false,
	`created_at` integer DEFAULT (unixepoch()) NOT NULL,
	`updated_at` integer DEFAULT (unixepoch()) NOT NULL
);
--> statement-breakpoint
CREATE TABLE `ml_datasets` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`original_name` text NOT NULL,
	`file_path` text NOT NULL,
	`file_size` integer,
	`mime_type` text,
	`row_count` integer,
	`col_count` integer,
	`columns_json` text,
	`inferred_task` text,
	`created_at` integer
);
--> statement-breakpoint
CREATE TABLE `ml_projects` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`dataset_id` text NOT NULL,
	`goal` text NOT NULL,
	`status` text DEFAULT 'idle' NOT NULL,
	`created_at` integer,
	`updated_at` integer
);
--> statement-breakpoint
CREATE TABLE `ml_run_logs` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`run_id` integer NOT NULL,
	`level` text DEFAULT 'info',
	`message` text NOT NULL,
	`created_at` integer,
	FOREIGN KEY (`run_id`) REFERENCES `ml_runs`(`id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
CREATE TABLE `ml_runs` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`project_id` integer NOT NULL,
	`stage` text DEFAULT 'eda' NOT NULL,
	`status` text DEFAULT 'pending' NOT NULL,
	`eda_result_json` text,
	`plan_json` text,
	`plan_approved` integer,
	`code_path` text,
	`model_path` text,
	`eval_json` text,
	`report_path` text,
	`error_message` text,
	`started_at` integer,
	`completed_at` integer,
	`created_at` integer,
	FOREIGN KEY (`project_id`) REFERENCES `ml_projects`(`id`) ON UPDATE no action ON DELETE cascade
);
