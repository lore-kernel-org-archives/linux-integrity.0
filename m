Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbdKMXzu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Nov 2017 18:55:50 -0500
Date: Tue, 14 Nov 2017 00:55:46 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kyle McMartin <kyle@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Subject: Re: [RFC PATCH v2] fw_lockdown: new micro LSM module to prevent
 loading unsigned firmware
Message-ID: <20171113235546.GG22894@wotan.suse.de>
References: <1510573414.3404.109.camel@linux.vnet.ibm.com>
 <20171113190505.GC22894@wotan.suse.de>
 <1510601807.3711.16.camel@linux.vnet.ibm.com>
 <20171113195154.GE22894@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171113195154.GE22894@wotan.suse.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Nov 13, 2017 at 08:51:54PM +0100, Luis R. Rodriguez wrote:
> On Mon, Nov 13, 2017 at 02:36:47PM -0500, Mimi Zohar wrote:
> > On Mon, 2017-11-13 at 20:05 +0100, Luis R. Rodriguez wrote:
> > > > + * fw_lockdown_read_file - prevent loading of unsigned firmware
> > > > + * @file: pointer to firmware
> > > > + * @read_id: caller identifier
> > > > + *
> > > > + * Prevent loading of unsigned firmware in lockdown mode.
> > > > + */
> > > > +static int fw_lockdown_read_file(struct file *file, enum kernel_read_file_id id)
> > > > +{
> > > > +	if (id == READING_FIRMWARE) {
> > > > +		if (!is_ima_appraise_enabled() &&
> > > > +		    kernel_is_locked_down("Loading of unsigned firmware"))
> > > > +			return -EACCES;
> > > > +	}

We also have READING_FIRMWARE_PREALLOC_BUFFER now. So the above
is missing a check for that as well.

  Luis
