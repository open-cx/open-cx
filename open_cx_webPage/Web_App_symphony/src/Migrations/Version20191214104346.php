<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20191214104346 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE presentation CHANGE id_speaker1 id_speaker1 INT DEFAULT NULL, CHANGE id_speaker2 id_speaker2 INT DEFAULT NULL, CHANGE id_speaker3 id_speaker3 INT DEFAULT NULL, CHANGE id_room id_room INT DEFAULT NULL, CHANGE title title VARCHAR(255) DEFAULT NULL, CHANGE summary summary VARCHAR(255) DEFAULT NULL, CHANGE start_time start_time DATETIME DEFAULT NULL, CHANGE end_time end_time DATETIME DEFAULT NULL, CHANGE hashtag hashtag VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE room CHANGE seats seats INT DEFAULT NULL, CHANGE seats_occupied seats_occupied INT DEFAULT NULL, CHANGE map_pose map_pose INT DEFAULT NULL, CHANGE id_code id_code VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE speaker CHANGE photo_location photo_location VARCHAR(255) DEFAULT NULL, CHANGE name name VARCHAR(255) DEFAULT NULL, CHANGE search_area search_area VARCHAR(255) DEFAULT NULL, CHANGE job_details job_details VARCHAR(255) DEFAULT NULL, CHANGE linked_in_profile linked_in_profile VARCHAR(255) DEFAULT NULL');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE presentation CHANGE id_speaker1 id_speaker1 INT DEFAULT NULL, CHANGE id_speaker2 id_speaker2 INT DEFAULT NULL, CHANGE id_speaker3 id_speaker3 INT DEFAULT NULL, CHANGE id_room id_room INT DEFAULT NULL, CHANGE title title VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`, CHANGE summary summary VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`, CHANGE start_time start_time DATETIME DEFAULT \'NULL\', CHANGE end_time end_time DATETIME DEFAULT \'NULL\', CHANGE hashtag hashtag VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`');
        $this->addSql('ALTER TABLE room CHANGE seats seats INT DEFAULT NULL, CHANGE seats_occupied seats_occupied INT DEFAULT NULL, CHANGE map_pose map_pose INT DEFAULT NULL, CHANGE id_code id_code VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`');
        $this->addSql('ALTER TABLE speaker CHANGE photo_location photo_location VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`, CHANGE name name VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`, CHANGE search_area search_area VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`, CHANGE job_details job_details VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`, CHANGE linked_in_profile linked_in_profile VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`');
    }
}
