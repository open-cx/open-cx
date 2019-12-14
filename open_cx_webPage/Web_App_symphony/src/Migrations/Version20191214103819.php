<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20191214103819 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE presentation (id INT AUTO_INCREMENT NOT NULL, room_id INT NOT NULL, id_speaker1 INT DEFAULT NULL, id_speaker2 INT DEFAULT NULL, id_speaker3 INT DEFAULT NULL, id_room INT DEFAULT NULL, title VARCHAR(255) DEFAULT NULL, summary VARCHAR(255) DEFAULT NULL, start_time DATETIME DEFAULT NULL, end_time DATETIME DEFAULT NULL, hashtag VARCHAR(255) DEFAULT NULL, INDEX IDX_9B66E89354177093 (room_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE presentation_speaker (presentation_id INT NOT NULL, speaker_id INT NOT NULL, INDEX IDX_E6F69B38AB627E8B (presentation_id), INDEX IDX_E6F69B38D04A0F27 (speaker_id), PRIMARY KEY(presentation_id, speaker_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE room (id INT AUTO_INCREMENT NOT NULL, seats INT DEFAULT NULL, seats_occupied INT DEFAULT NULL, map_pose INT DEFAULT NULL, id_code VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE speaker (id INT AUTO_INCREMENT NOT NULL, photo_location VARCHAR(255) DEFAULT NULL, name VARCHAR(255) DEFAULT NULL, search_area VARCHAR(255) DEFAULT NULL, job_details VARCHAR(255) DEFAULT NULL, linked_in_profile VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE presentation ADD CONSTRAINT FK_9B66E89354177093 FOREIGN KEY (room_id) REFERENCES room (id)');
        $this->addSql('ALTER TABLE presentation_speaker ADD CONSTRAINT FK_E6F69B38AB627E8B FOREIGN KEY (presentation_id) REFERENCES presentation (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE presentation_speaker ADD CONSTRAINT FK_E6F69B38D04A0F27 FOREIGN KEY (speaker_id) REFERENCES speaker (id) ON DELETE CASCADE');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE presentation_speaker DROP FOREIGN KEY FK_E6F69B38AB627E8B');
        $this->addSql('ALTER TABLE presentation DROP FOREIGN KEY FK_9B66E89354177093');
        $this->addSql('ALTER TABLE presentation_speaker DROP FOREIGN KEY FK_E6F69B38D04A0F27');
        $this->addSql('DROP TABLE presentation');
        $this->addSql('DROP TABLE presentation_speaker');
        $this->addSql('DROP TABLE room');
        $this->addSql('DROP TABLE speaker');
    }
}
