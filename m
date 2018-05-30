Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:36543 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932238AbeE3Uyu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 16:54:50 -0400
Date: Wed, 30 May 2018 23:54:38 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>, jmorris@namei.org
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: fix race condition in tpm_common_write()
Message-ID: <20180530205438.GA27912@linux.intel.com>
References: <152702503883.25871.17829919385428251068.stgit@tstruk-mobl1.jf.intel.com>
 <20180523135003.GG363@linux.intel.com>
 <20180530171315.GA23184@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180530171315.GA23184@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

James,

On Wed, May 30, 2018 at 08:13:15PM +0300, Jarkko Sakkinen wrote:
> On Wed, May 23, 2018 at 04:50:03PM +0300, Jarkko Sakkinen wrote:
> > On Tue, May 22, 2018 at 02:37:18PM -0700, Tadeusz Struk wrote:
> > > There is a race condition in tpm_common_write function allowing
> > > two threads on the same /dev/tpm<N>, or two different applications
> > > on the same /dev/tpmrm<N> to overwrite each other commands/responses.
> > > Fixed this by taking the priv->buffer_mutex early in the function.
> > > 
> > > Also converted the priv->data_pending from atomic to a regular size_t
> > > type. There is no need for it to be atomic since it is only touched
> > > under the protection of the priv->buffer_mutex.
> > > 
> > > v2: convert data_pending from atomic to a regular size_t type.
> > > 
> > > Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> > > ---
> > 
> > The changel log should be here in diff stat (i.e. at this point) so that
> > the change log does not get pulled into the final commit message.
> > 
> > /Jarkko
> 
> I pushed it now with appropriate tags, please check.
> 
> /Jarkko

Should I make a follow up PR for 4.18 with only this fix included?

/Jarkko
