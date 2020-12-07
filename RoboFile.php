<?php
/** @noinspection All*/

/**
 * This is project's console commands configuration for Robo task runner.
 *
 * @see http://robo.li/
 */
class RoboFile extends \Robo\Tasks
{
    public function deploy()
    {
        $this->taskExec('rsync -rz public/ dev.seb7.fr:/var/www/seb7.fr/blog')->run();
    }
}
