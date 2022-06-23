import { LightningElement, api } from 'lwc';
import RESUME_ASSETS from '@salesforce/resourceUrl/resume';

export default class ResumeLinks extends LightningElement {
  @api linkedin;
  @api github;
  @api trailhead;
  @api website;

  linkedinSrc = RESUME_ASSETS + '/linkedin.png';
  githubSrc = RESUME_ASSETS + '/github.png';
  trailheadSrc = RESUME_ASSETS + '/trailhead.png';
}
