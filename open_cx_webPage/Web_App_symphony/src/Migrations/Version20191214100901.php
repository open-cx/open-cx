<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20191214100901 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE presentation_speaker (presentation_id INT NOT NULL, speaker_id INT NOT NULL, INDEX IDX_E6F69B38AB627E8B (presentation_id), INDEX IDX_E6F69B38D04A0F27 (speaker_id), PRIMARY KEY(presentation_id, speaker_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE presentation_speaker ADD CONSTRAINT FK_E6F69B38AB627E8B FOREIGN KEY (presentation_id) REFERENCES presentation (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE presentation_speaker ADD CONSTRAINT FK_E6F69B38D04A0F27 FOREIGN KEY (speaker_id) REFERENCES speaker (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE presentation ADD room_id INT NOT NULL, CHANGE id_speaker1 id_speaker1 INT DEFAULT NULL, CHANGE id_speaker2 id_speaker2 INT DEFAULT NULL, CHANGE id_speaker3 id_speaker3 INT DEFAULT NULL, CHANGE id_room id_room INT DEFAULT NULL, CHANGE title title VARCHAR(255) DEFAULT NULL, CHANGE summary summary VARCHAR(255) DEFAULT NULL, CHANGE start_time start_time DATETIME DEFAULT NULL, CHANGE end_time end_time DATETIME DEFAULT NULL, CHANGE hashtag hashtag VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE presentation ADD CONSTRAINT FK_9B66E89354177093 FOREIGN KEY (room_id) REFERENCES room (id)');
        $this->addSql('CREATE INDEX IDX_9B66E89354177093 ON presentation (room_id)');
        $this->addSql('ALTER TABLE room CHANGE seats seats INT DEFAULT NULL, CHANGE seats_occupied seats_occupied INT DEFAULT NULL, CHANGE map_pose map_pose INT DEFAULT NULL, CHANGE id_code id_code VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE speaker CHANGE photo_location photo_location VARCHAR(255) DEFAULT NULL, CHANGE name name VARCHAR(255) DEFAULT NULL, CHANGE search_area search_area VARCHAR(255) DEFAULT NULL, CHANGE job_details job_details VARCHAR(255) DEFAULT NULL, CHANGE linked_in_profile linked_in_profile VARCHAR(255) DEFAULT NULL');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('DROP TABLE presentation_speaker');
        $this->addSql('ALTER TABLE presentation DROP FOREIGN KEY FK_9B66E89354177093');
        $this->addSql('DROP INDEX IDX_9B66E89354177093 ON presentation');
        $this->addSql('ALTER TABLE presentation DROP room_id, CHANGE id_speaker1 id_speaker1 INT DEFAULT NULL, CHANGE id_speaker2 id_speaker2 INT DEFAULT NULL, CHANGE id_speaker3 id_speaker3 INT DEFAULT NULL, CHANGE id_room id_room INT DEFAULT NULL, CHANGE title title VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`, CHANGE summary summary VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`, CHANGE start_time start_time DATETIME DEFAULT \'NULL\', CHANGE end_time end_time DATETIME DEFAULT \'NULL\', CHANGE hashtag hashtag VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`');
        $this->addSql('ALTER TABLE room CHANGE seats seats INT DEFAULT NULL, CHANGE seats_occupied seats_occupied INT DEFAULT NULL, CHANGE map_pose map_pose INT DEFAULT NULL, CHANGE id_code id_code VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`');
        $this->addSql('ALTER TABLE speaker CHANGE photo_location photo_location VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`, CHANGE name name VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`, CHANGE search_area search_area VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`, CHANGE job_details job_details VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`, CHANGE linked_in_profile linked_in_profile VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT \'NULL\' COLLATE `utf8mb4_unicode_ci`');
    }
}
