Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30597 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbeBHMga (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 07:36:30 -0500
Date: Thu, 8 Feb 2018 14:36:24 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, ltp@lists.linux.it,
        linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        Thiebaud Weksteen <tweek@google.com>,
        Petr Vandrovec <petr@vmware.com>
Subject: Re: Hidden TPM questions in the LTP IMA posts
Message-ID: <20180208123624.3ib7w7hgj2kk7pfu@linux.intel.com>
References: <1516978199.29187.43.camel@linux.vnet.ibm.com>
 <20180131133241.rbxy252l6p5rqlh2@linux.intel.com>
 <1517416161.3469.142.camel@linux.vnet.ibm.com>
 <1517820147.7570.4.camel@linux.intel.com>
 <3279a223-a638-a21d-aa24-1879cf20df4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3279a223-a638-a21d-aa24-1879cf20df4c@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Feb 05, 2018 at 02:34:49PM +0100, Javier Martinez Canillas wrote:
> Support for reading from EFI is what landed for this release, but only the
> TPM 1.2 (SHA1) format is supported, there's still not support for TPM 2.0
> (crypto agile). You can see that in drivers/firmware/efi/libstub/tpm.c:
> 
> void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
> {
> ...
> 	status = efi_call_proto(efi_tcg2_protocol, get_event_log, tcg2_protocol,
> 				EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2,
> 				&log_location, &log_last_entry, &truncated);
> ...
> }
> 
> void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
> {
> 	/* Only try to retrieve the logs in 1.2 format. */
> 	efi_retrieve_tpm2_eventlog_1_2(sys_table_arg);
> }
> 
> But all the bits for TPM 2.0 (crypto agile) support seems to already be in
> drivers/char/tpm/tpm2_eventlog.c, are only missing in the EFI stub AFAICT.

This is correct. DT based platforms already support crypto agile.

> Now, on latest TCG ACPI Specification (Revision 8, August 18, 2017) [1],
> the spec does mention that the ACPI table with signature 'TPM2' can have
> the LASA and LAML as optional fields. This is mentioned in section 7.3
> "ACPI Table for TPM 2.0".

Oh, this is new to me. We can support it as soon as there is a plaform
that has it. I do not have any at this point.

/Jarkko
